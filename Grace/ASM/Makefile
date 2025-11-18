NAME := Grace
SRCS := Grace.s
NASM := nasm
NASMFLAGS := -felf64 -g
CC := cc
LD_FLAGS := -Wl,-z,noexecstack
RM := rm -f
OBJS := $(SRCS:.s=.o)

.PHONY: all clean fclean re

all: $(NAME)

$(NAME): $(SRCS)
	$(NASM) $(NASMFLAGS) -o $(NAME).o $(SRCS) && $(CC) $(NAME).o $(LD_FLAGS) -o $(NAME)

clean:
	$(RM) $(OBJS) Grace_kid.s

fclean: clean
	$(RM) $(NAME)

re: fclean all