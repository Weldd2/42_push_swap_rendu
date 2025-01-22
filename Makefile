# **************************************************************************** #
#                                   CONFIG                                     #
# **************************************************************************** #

NAME        = push_swap
CC          = cc
CFLAGS      = -Wall -Wextra -Werror
RM          = rm -f
RMDIR       = rm -rf

# On déclare le dossier dans lequel on veut stocker nos fichiers objets
OBJDIR      = obj

# -----------------------------------------------------------------------------
# INCLUDES
# -----------------------------------------------------------------------------
INCS        = -I include            \
              -I lib/mem/include    \
              -I lib/str/include

# **************************************************************************** #
#                              SOURCES PRINCIPAUX                              #
# **************************************************************************** #
push_swap_SRCS = \
src/push_swap.c \
src/algorithm/closest_index.c \
src/algorithm/move_operations.c \
src/algorithm/move_operations2.c \
src/algorithm/rotation_cases.c \
src/algorithm/rotation_costs.c \
src/algorithm/sort_operations.c \
src/algorithm/turk_algorithm.c \
src/args/args.c \
src/ope/ope.c \
src/ope/push.c \
src/ope/rotate.c \
src/ope/rrotate.c \
src/tools/tools.c \
src/tools/max_min.c \
src/tools/atoi.c \
src/error.c \
src/init.c \
src/node.c \

# **************************************************************************** #
#                              LIB : MEM                                       #
# **************************************************************************** #
MEM_SRCS = \
lib/mem/src/arena/mem_arena.c \
lib/mem/src/arena/mem_arena_alloc.c \
lib/mem/src/arena/mem_arena_calloc.c \
lib/mem/src/arena/mem_arena_free.c \
lib/mem/src/arena/mem_arena_realloc.c \
lib/mem/src/classic/mem_bzero.c \
lib/mem/src/classic/mem_calloc.c \
lib/mem/src/classic/mem_free.c \
lib/mem/src/classic/mem_freetab.c \
lib/mem/src/classic/mem_malloc.c \
lib/mem/src/classic/mem_memchr.c \
lib/mem/src/classic/mem_memcmp.c \
lib/mem/src/classic/mem_memcpy.c \
lib/mem/src/classic/mem_memmove.c \
lib/mem/src/classic/mem_memset.c \
lib/mem/src/classic/mem_realloc.c \
lib/mem/src/mgc/mem_mgc.c \
lib/mem/src/mgc/mem_mgc_alloc.c \
lib/mem/src/mgc/mem_mgc_calloc.c \
lib/mem/src/mgc/mem_mgc_free.c

# **************************************************************************** #
#                              LIB : STR                                       #
# **************************************************************************** #
STR_SRCS = \
lib/str/src/cat/str_strcat_until.c \
lib/str/src/cat/str_strlcat.c \
lib/str/src/copy/str_strcpy_until.c \
lib/str/src/copy/str_strlcpy.c \
lib/str/src/search/str_strchr.c \
lib/str/src/search/str_strcontains.c \
lib/str/src/search/str_strendwith.c \
lib/str/src/search/str_strequals.c \
lib/str/src/search/str_strncmp.c \
lib/str/src/search/str_strnstr.c \
lib/str/src/search/str_strstartwith.c \
lib/str/src/str_split.c \
lib/str/src/str_strdup.c \
lib/str/src/str_striteri.c \
lib/str/src/str_strjoin.c \
lib/str/src/str_strlen.c \
lib/str/src/str_strmapi.c \
lib/str/src/str_strrchr.c \
lib/str/src/str_strsplitchar.c \
lib/str/src/str_strtrim.c \
lib/str/src/sub/str_extract_sub.c \
lib/str/src/sub/str_replace_sub.c \
lib/str/src/sub/str_slice.c

# **************************************************************************** #
#                    LISTE GLOBALE DES SOURCES ET DES OBJETS                   #
# **************************************************************************** #
SRCS        = $(push_swap_SRCS) $(MEM_SRCS) $(STR_SRCS)

# On veut que chaque .c soit compilé en obj/<path>.o
# ex: src/push_swap.c      -> obj/src/push_swap.o
#     lib/str/src/str_.. -> obj/lib/str/src/str_..o
OBJS        = $(SRCS:%.c=$(OBJDIR)/%.o)

# **************************************************************************** #
#                                   RULES                                      #
# **************************************************************************** #

# -----------------------------------------------------------------------------
# Règle par défaut : all
# -----------------------------------------------------------------------------
all: $(NAME)

# -----------------------------------------------------------------------------
# Compilation de l'exécutable final
# -----------------------------------------------------------------------------
$(NAME): $(OBJS)
	$(CC) $(CFLAGS) $(INCS) $^ $(LIBS) -o $@

# -----------------------------------------------------------------------------
# Compilation des .c -> .o, placés dans obj/...
# -----------------------------------------------------------------------------
$(OBJDIR)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(INCS) -c $< -o $@

# -----------------------------------------------------------------------------
# Nettoyage des fichiers objets
# -----------------------------------------------------------------------------
clean:
	$(RMDIR) $(OBJDIR)

# -----------------------------------------------------------------------------
# Nettoyage complet (exécutable + objets)
# -----------------------------------------------------------------------------
fclean: clean
	$(RM) $(NAME)

# -----------------------------------------------------------------------------
# Recompilation totale
# -----------------------------------------------------------------------------
re: fclean all

# -----------------------------------------------------------------------------
# Installation (submodule) - si nécessaire
# -----------------------------------------------------------------------------
install:
	git submodule init
	git submodule update
	@echo "Submodules initialized/updated."

# -----------------------------------------------------------------------------
# Règles de debug, valgrind
# -----------------------------------------------------------------------------
VALGRIND_FLAGS = --leak-check=full --show-leak-kinds=all
TEST_ARGUMENTS = 

valgrind: CFLAGS += -g
valgrind: re
	valgrind $(VALGRIND_FLAGS) ./$(NAME) $(TEST_ARGUMENTS)

debug: CFLAGS += -g
debug: re

# -----------------------------------------------------------------------------
# Déclaration des règles phony
# -----------------------------------------------------------------------------
.PHONY: all clean fclean re install debug valgrind
