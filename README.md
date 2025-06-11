CASO PROPUESTO:Sistema de Gestión de Préstamos y Pagos para Banco

1.- Descripción del problema:
Un banco desea automatizar la gestión de los préstamos que otorga a sus clientes, incluyendo el seguimiento detallado de los pagos realizados y el control del estado de cada préstamo.

2.- Objetivo del proyecto:
•	Registrar y administrar préstamos otorgados a clientes.
•	Controlar el calendario de pagos de cada préstamo.
•	Registrar los pagos realizados y actualizar los saldos pendientes.
•	Gestionar diferentes tipos de préstamos con distintas condiciones (tasas de interés, plazos).
•	Generar reportes sobre estado de préstamos, morosidad y movimientos de pagos.

3.- Entidades Principales:
Entidad	Atributos principales
Clientes	ID, Nombre, numero_idc, tipo_de_idc, tipo_de_cliente, dirección, Teléfono, Email.
Préstamos	ID, cliente_id, responsable_id, sucursal_id, tipo_de_prestamo_id, tasa_interes, monto_prestamo,plazo, fecha_inicio, estado.
Cuotas	ID, prestamo_id, numero_cuota, fecha_vencimiento, monto_cuota, estado_pago.
Pagos	ID, cuota_id, fecha_pago, monto_pagado, método_pago 
responsables	ID, nombre, código_empleado, cargo, correo.
Detalle de pagos	ID, cuota_id, pago_id, monto_afectado
Tipo de prestamos	ID, nombre_tipo
Sucursal	ID, código, nombre, ciudad, región, dirección, estado, teléfono.



4. Relaciones
Un Cliente puede tener varios Préstamos.

Cada Préstamo está compuesto por varias Cuotas.

Cada Cuota puede recibir uno o más Pagos (por si el pago es parcial).

Cada Préstamo corresponde a un TipoPréstamo con condiciones específicas.

5. Requisitos Funcionales
Crear un nuevo préstamo para un cliente con generación automática del plan de pagos.

Registrar pagos parciales o totales de cuotas.

Actualizar automáticamente el estado de la cuota (pagada, pendiente o vencida).

Consultar el estado de un préstamo (saldo, cuotas pagadas y pendientes).

Generar alertas o reportes de préstamos morosos.

Consultar el historial de pagos de un cliente o un préstamo específico.

6. Ejemplo de Proceso de Negocio
Solicitud: Cliente solicita un préstamo.

Aprobación: Se aprueba el préstamo con condiciones de monto, plazo y tasa de interés.

Desembolso: Se registra el préstamo y se genera el calendario de cuotas.

Pagos: Cliente realiza pagos según calendario; cada pago actualiza el estado de la cuota.

Seguimiento: Banco revisa estado y morosidad, envía recordatorios o acciones de cobranza si corresponde.

Cierre: Una vez todas las cuotas están pagadas, se cierra el préstamo.

*Diagrama Entidad-Relación
![image](https://github.com/user-attachments/assets/0b0726fe-ac09-4aee-b080-0782005b2e04)

*Módelo Lógico
[image](https://github.com/user-attachments/assets/88aded49-4b35-465b-a1b8-146e0629632c)

*Modelo físico

![image](https://github.com/user-attachments/assets/a32b1e46-26b4-4332-94e6-090f18823fc9)



