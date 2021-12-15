# cookbook

## Minuta

Se trata de un sistema para bares o restaurantes donde en cada mesa se coloca una tablet para realizar pedidos a un mozo asignado a dicha mesa ***(rol mesa)***, la app cuenta con el catálogo de comidas y de bebidas del negocio y un carrito para armar un pedido para esa mesa. Una vez confirmado el pedido se le informa al mozo sobre dicho pedido y este confirma la recepción. 

Del lado del mozo la app cuenta con un inicio de sesión ***(rol mozo)*** el cual tiene asignadas ciertas mesas de las cuales llegan pedidos para ser confirmados, el mozo cuenta con una lista de pedidos los cuales se asocian a una mesa. Cuando el mozo confirma avisa al buffet para que preparen el pedido e informa a la mesa sobre la confirmación.

Por otra parte se pueden cargar, editar y eliminar comidas y bebidas al sistema ***(rol administrador)*** así cómo también cuentas de mozo y mesas.

## Modelo del dominio

![md](https://i.gyazo.com/0b67e635b1676975f35993cceb810124.png)

## Casos de uso

* CU0 - Loguear usuario 
* CU1 - Registrar cuenta de mozo
* CU2 - Registrar una mesa
* CU3 - Cargar una comida al menú
* CU4 - Modificar una mesa
* CU5 - Modificar cuenta de mozo
* CU6 - Modificar comida del menú
* CU7 - Eliminar cuenta de mozo
* CU8 - Eliminar una mesa
* CU9 - Eliminar una comida del menú
* CU10 - Buscar una comida del menú
* CU11 - Ver detalle de una comida
* CU12 - Agregar comidas a la lista del pedido
* CU13 - Confirmar pedido
* CU14 - Ver estado del pedido
* CU15 - Llamar al mozo

