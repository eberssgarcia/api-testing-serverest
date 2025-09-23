Feature: Obtener el listado completo de usuarios
  Como un administrador del sistema,
  Quiero poder gestionar los usuarios a través de la API,
  Para administrar la base de datos de usuarios.

  Background:
    * url urlBase
    #VALIDAR  ESQUEMA JSON
    * def schema = Java.type('util.schemaValidator')

  @tag3 @regresion
  Scenario: Obtener el listado completo de usuarios
    #OBETENER LISTADO COMPLETO DE USUARIOS
    Given path '/usuarios'
    When method GET
    Then status 200
    * print response
    And match response == '#object'
    #VALIDAR ESQUEMA
    And string current_schema = response
    And string expected_schema = read('classpath:schema/schema-get-users.json')
    And assert schema.isValid(current_schema, expected_schema)