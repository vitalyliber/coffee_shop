# Coffee Shop

System for sale in your Coffee Shop :coffee:

![coffee_shop recording](https://image.ibb.co/cBww8v/Peek_2017_03_19_12_02.gif)

## How to run Coffee Shop: 

You need Docker Compose for starting application. :rocket:

Run this command in your terminal:


```shell
docker-compose up -d db
docker-compose build app
docker-compose run app rake db:create db:migrate
docker-compose up -d app
```

[Link to DEMO](http://coffee-shop.toel.ru) :herb:
