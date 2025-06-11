Caso Propuesto: Sistema de Gestión de Préstamos y Pagos para Banco
1. Contexto
Un banco desea automatizar la gestión de los préstamos que otorga a sus clientes, incluyendo el seguimiento detallado de los pagos realizados y el control del estado de cada préstamo.

2. Objetivos
Registrar y administrar préstamos otorgados a clientes.

Controlar el calendario de pagos de cada préstamo.

Registrar los pagos realizados y actualizar los saldos pendientes.

Gestionar diferentes tipos de préstamos con distintas condiciones (tasas de interés, plazos).

Generar reportes sobre estado de préstamos, morosidad y movimientos de pagos.

3. Entidades Principales
Entidad	Atributos Clave
Cliente	ID_cliente, Nombre, Documento_identidad, Dirección, Teléfono, Email
Préstamo	ID_préstamo, ID_cliente, Tipo_préstamo, Monto_préstamo, Tasa_interés, Plazo, Fecha_inicio, Estado (activo, pagado, moroso)
Cuota	ID_cuota, ID_préstamo, Número_cuota, Fecha_vencimiento, Monto_cuota, Estado_pago (pendiente, pagada, vencida)
Pago	ID_pago, ID_cuota, Fecha_pago, Monto_pagado, Método_pago (efectivo, transferencia, tarjeta)
TipoPréstamo	ID_tipo, Nombre_tipo (personal, hipotecario, vehicular), Tasa_interés_base

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



