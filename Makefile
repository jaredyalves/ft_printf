NAME		:= libftprintf.a

SRCDIR		:= src
OBJDIR		:= obj
INCDIR		:= include

SRCS		:= \
	$(SRCDIR)/ft_printf.c \

OBJS		:= $(patsubst $(SRCDIR)/%.c,$(OBJDIR)/%.o,$(SRCS))
INCS		:= \
	$(INCDIR)/ft_printf.h

CC			:= cc
INCLUDES	:= -I$(INCDIR)
CFLAGS		:= -O3 -Wall -Werror -Wextra $(INCLUDES)
LDFLAGS		:=

AR			:= ar
ARFLAGS		:= -rcs

RM			:= rm
RMFLAGS		:= -rf

.PHONY: all clean fclean re

all: $(NAME)

$(NAME): $(OBJS)
	$(AR) $(ARFLAGS) $(NAME) $(OBJS)

$(OBJDIR)/%.o: $(SRCDIR)/%.c $(INCS)
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -o $@ -c $<

clean:
	$(RM) $(RMFLAGS) $(OBJDIR)

fclean: clean
	$(RM) $(RMFLAGS) $(NAME)

re: fclean all
