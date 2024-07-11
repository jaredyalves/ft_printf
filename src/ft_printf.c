/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_printf.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jcapistr <jcapistr@student.42porto.com>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/12/28 14:58:58 by jcapistr          #+#    #+#             */
/*   Updated: 2023/01/15 13:28:02 by jcapistr         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_printf.h"

#include <stdarg.h>
#include <unistd.h>

static size_t	write_string(const char *s)
{
	size_t	written;

	written = 0;
	if (!s)
		s = "(null)";
	while (*s)
		written += write(1, s++, 1);
	return (written);
}

static size_t	write_number(ssize_t n, const int b, const char *bs)
{
	size_t	i;
	size_t	written;
	char	buffer[65];

	i = 0;
	written = 0;
	if (n < 0)
	{
		n = -n;
		written += write(1, "-", 1);
	}
	if (n == 0)
		buffer[i++] = '0';
	else
	{
		while (n > 0)
		{
			buffer[i++] = bs[n % b];
			n /= b;
		}
	}
	while (i > 0)
		written += write(1, &(buffer[--i]), 1);
	return (written);
}

static size_t	write_memory(size_t m)
{
	size_t	written;

	written = 0;
	if (m == 0)
		written += write_string("(nil)");
	else
	{
		written += write_string("0x");
		written += write_number(m, 16, "0123456789abcdef");
	}
	return (written);
}

static size_t	write_format(const int f, va_list args)
{
	char	c;

	if (f == 'c')
	{
		c = va_arg(args, int);
		return (write(1, &c, 1));
	}
	if (f == 's')
		return (write_string(va_arg(args, const char *)));
	if (f == 'd' || f == 'i')
		return (write_number(va_arg(args, int), 10, "0123456789"));
	if (f == 'u')
		return (write_number(va_arg(args, size_t), 10, "0123456789"));
	if (f == 'x')
		return (write_number(va_arg(args, size_t), 16, "0123456789abcdef"));
	if (f == 'X')
		return (write_number(va_arg(args, size_t), 16, "0123456789ABCDEF"));
	if (f == 'p')
		return (write_memory(va_arg(args, size_t)));
	if (f == '%')
		return (write(1, "%", 1));
	return (0);
}

int	ft_printf(const char *format, ...)
{
	const char	*p;
	size_t		written;
	va_list		args;

	p = format;
	written = 0;
	va_start(args, format);
	while (*p)
	{
		if (*p == '%' && *(p + 1))
			written += write_format(*(++p), args);
		else
			written += write(1, p, 1);
		p++;
	}
	return (written);
}
