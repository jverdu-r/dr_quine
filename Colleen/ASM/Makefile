NAME := Colleen
SRCS := Colleen.s
NASM := nasm
NASMFLAGS := -felf64 -g
CC := cc
LD_FLAGS := -Wl,-z,noexecstack
RM := rm -f
OBJS := $(SRCS:.s=.o)

.PHONY: all build test diff clean fclean re

all: $(NAME)

$(NAME): $(OBJS)
	$(CC) $(OBJS) $(LD_FLAGS) -o $(NAME)

%.o: %.s
	$(NASM) $(NASMFLAGS) -o $@ $<

clean:
	$(RM) $(OBJS)

fclean: clean
	$(RM) $(NAME)

re: fclean all