NAME := Sully
SRCS := Sully.s
NASM := nasm
NASMFLAGS := -felf64 -g
CC := cc
LD_FLAGS := -Wl,-z,noexecstack
RM := rm -f
OBJS := $(SRCS:.s=.o)

.PHONY: all build test diff clean fclean re

all: $(NAME)

$(NAME): $(SRCS)
	$(NASM) $(NASMFLAGS) -o $(NAME).o $(SRCS) && $(CC) -no-pie $(NAME).o $(LD_FLAGS) -o $(NAME)

clean:
	$(RM) $(OBJS)

fclean: clean
	$(RM) $(NAME)
	$(RM) Sully_*.c Sully_*

re: fclean all