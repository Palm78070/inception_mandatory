# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rthammat <rthammat@42.fr>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/08/14 18:25:15 by rthammat          #+#    #+#              #
#    Updated: 2023/08/14 23:33:53 by rthammat         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

C1:= wordpress

C2:= mariadb

build:
	cd srcs && docker-compose build && cd ../

# up => create + start containers defined in compose file
up:
	cd srcs && docker-compose up -d && cd ../

down:
	cd srcs && docker-compose down && cd ../

# start => start containers that currently stop
start:
	cd srcs && docker-compose start && cd ../

stop:
	cd srcs && docker-compose stop && cd ../

ps:
	docker ps

logs:
	cd srcs && docker-compose logs && cd ../

images:
	docker images

rm_images:
	docker images -q | xargs -r docker rmi -f

ping:
	docker exec $(C1) ping $(C2) -c2

network:
	docker network inspect -f '{{range .Containers}}{{.Name}} {{end}}' inception

wp_usr:
	docker exec -it wordpress wp --allow-root --path=var/www/html user list

.PHONY: build up down start stop ps images rm_images ping network wp_usr
