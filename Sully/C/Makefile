NAME := Sully
SRCS := Sully.c
CC := cc
CFLAGS := -Wall -Wextra -Werror
RM := rm -rf
OBJS := $(SRCS:.c=.o)

.PHONY: all build test diff clean fclean re

all: $(NAME)

$(NAME): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $(NAME)   -lbsd

re: fclean all

clean:
	$(RM) $(OBJS)

fclean: clean
	$(RM) $(NAME)
	$(RM) Sully_*.c Sully_*

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@