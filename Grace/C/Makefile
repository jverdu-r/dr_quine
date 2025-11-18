NAME := Grace
SRCS := Grace.c
CC := cc
CFLAGS := -Wall -Wextra -Werror
RM := rm -f

.PHONY: all clean fclean re

all: $(NAME)

$(NAME): $(SRCS)
	$(CC) $(CFLAGS) -o $(NAME) $(SRCS)

clean:
	$(RM) Grace_kid.c

fclean: clean
	$(RM) $(NAME)

re: fclean all