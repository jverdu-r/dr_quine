NAME := Colleen
SRCS := Colleen.s
NASM := nasm
NASMFLAGS := -felf64 -g
CC := gcc
LD_FLAGS := -Wl,-z,noexecstack
RM := rm -f
OBJS := $(SRCS:.s=.o)

.PHONY: all build test diff clean fclean re

all: $(NAME)

$(NAME): $(SRCS)
	$(NASM) $(NASMFLAGS) -o $(NAME).o $(SRCS) && $(CC) $(NAME).o $(LD_FLAGS) -o $(NAME)

clean:
	$(RM) $(OBJS)

fclean: clean
	$(RM) $(NAME)

re: fclean all