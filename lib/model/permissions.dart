enum Permission implements Comparable<Permission> {
  config('config:show', 'Configurações'),
  costCenters('cost centers:show', 'Centros de custo'),
  customers('customers:show', 'Clientes'),
  dashboard('dashboard', 'Dashboard'),
  devices('devices:show', 'Equipamentos'),
  drivers('drivers:show', 'Motoristas'),
  expenses('expenses:show', 'Despesas'),
  finesAlert('fine alert:show', 'Alertas de multas'),
  history('history:show', 'Histórico'),
  itinerary('itinerary:show', 'Itinerário'),
  journey('journey:show', 'Jornada'),
  kindOfFuel('kind of fuel:show', 'Tipos de combustível'),
  maintenances('maintenances:show', 'Manutenções'),
  outputControl('output control:show', 'Controle de saída'),
  peripherals('peripherals:show', 'Periféricos'),
  plans('plans:show', 'Planos'),
  secondTicket('second ticket:show', 'Segunda Via do Boleto'),
  sinistro('sinistro:show', 'Sinistro'),
  users('users:show', 'Usuários'),
  vehicleEvent('vehicle event:show', 'Eventos de veículo'),
  vehicleKind('vehicle kind:show', 'Tipos de veículo'),
  vehicleReport('vehicleReport:show', 'Relatórios de veículo'),
  vehicles('vehicles:show', 'Veículos'),
  reportMovingAndStop('report moving stop:show', 'Deslocamento'),
  ;

  final String permission;
  final String name;

  const Permission(this.permission, this.name);

  @override
  int compareTo(Permission other) => permission.compareTo(other.permission);
}
