NAME		:= template
NAME_BONUS	:= template_bonus

SRCDIR		:= src
OBJDIR		:= obj
INCDIR		:= include

SRCS		:= \
	$(SRCDIR)/main.c \

SRCS_BONUS	:= \
	$(SRCDIR)/main_bonus.c \

OBJS		:= $(patsubst $(SRCDIR)/%.c,$(OBJDIR)/%.o,$(SRCS))
OBJS_BONUS	:= $(patsubst $(SRCDIR)/%.c,$(OBJDIR)/%.o,$(SRCS_BONUS))
INCS		:= $(INCDIR)/template.h
INCS_BONUS	:= $(INCDIR)/template_bonus.h

CC			:= cc
INCLUDES	:= -I$(INCDIR)
CFLAGS		:= -O3 -Wall -Werror -Wextra $(INCLUDES)
LDFLAGS		:=

RM			:= rm
RMFLAGS		:= -rf

.PHONY: all bonus clean fclean re

all: $(NAME)

bonus: $(NAME_BONUS)

$(NAME): $(OBJS)
	$(CC) -o $@ $(OBJS) $(LDFLAGS)

$(NAME_BONUS): $(OBJS_BONUS)
	$(CC) -o $@ $(OBJS_BONUS) $(LDFLAGS)

$(OBJDIR)/%.o: $(SRCDIR)/%.c $(INCS) $(INCS_BONUS)
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -o $@ -c $<

clean:
	$(RM) $(RMFLAGS) $(OBJDIR)

fclean: clean
	$(RM) $(RMFLAGS) $(NAME) $(NAME_BONUS)

re: fclean all
