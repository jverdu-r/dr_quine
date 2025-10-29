NAME := Colleen
SRCS := Colleen.asm
NASM := nasm
NASMFLAGS := -felf64 -g
CC := cc
LD_FLAGS := -no-pie -Wl,-z,noexecstack
RM := rm -f
OBJS := $(SRCS:.asm=.o)

.PHONY: all build test diff clean fclean re

all: $(NAME)

$(NAME): $(OBJS)
	$(CC) $(OBJS) $(LD_FLAGS) -o $(NAME)

%.o: %.asm
	$(NASM) $(NASMFLAGS) -o $@ $<

clean:
	$(RM) $(OBJS)

fclean: clean
	$(RM) $(NAME)

re: fclean all