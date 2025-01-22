/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: antoinemura <antoinemura@student.42.fr>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/12/06 13:59:15 by antoinemura       #+#    #+#             */
/*   Updated: 2025/01/22 19:21:02 by antoinemura      ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"
#include <stdio.h>
#include <stdlib.h>

int	main(int argc, char **argv)
{
	t_list	list_a;
	t_list	list_b;
	int		min_index;

	parse_args(argc, argv, &list_a, &list_b);
	turk_algorithm(&list_a, &list_b);
	min_index = 0;
	min_index = find_min_index(list_a.head);
	while (list_a.head->value != list_a.min)
	{
		if (min_index > list_a.length / 2)
			rrotate(&list_a);
		else
			rotate(&list_a);
	}
	mem_mgc_free();
	return (0);
}
