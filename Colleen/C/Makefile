NAME := Colleen
SRCS := Colleen.c
CC := cc
CFLAGS := -Wall -Wextra -Werror
RM := rm -rf
OBJS := $(SRCS:.c=.o)

.PHONY: all build test diff clean fclean re

all: $(NAME)

$(NAME): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $(NAME)

re: fclean all

clean:
	$(RM) $(OBJS)

fclean: clean
	$(RM) $(NAME)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@