Feature: Obtener usuario por ID
  Como un administrador del sistema,
  Quiero poder gestionar los usuarios a través de la API,
  Para administrar la base de datos de usuarios.

  Background:
    * url urlBase
    #VALIDAR  ESQUEMA JSON
    * def schema = Java.type('util.schemaValidator')

  @tag4 @regresion
  Scenario: Obtener el listado completo de usuarios
    #OBETENER ID DE USUARIO
    * def obtenerId = call read('classpath:bdd/serverest/post-user.feature@creacionUsuario')
    * def id = obtenerId.id
    #LISTAR USUARIO POR ID (USUARIO CREADO)
    Given path '/usuarios/' + id
    When method GET
    Then status 200
    * print response
    And match response == '#object'
    #VALIDAR ESQUEMA
    And string current_schema = response
    And string expected_schema = read('classpath:schema/schema-get-users.json')
    And assert schema.isValid(current_schema, expected_schema)

  @tag7 @regresion
  Scenario: Listar usuario por ID no existente
    #OBETENER ID DE USUARIO
    * def id = '1234HTGJ5678JGTU'
    #LISTAR USUARIO POR ID (USUARIO CREADO)
    Given path '/usuarios/' + id
    When method GET
    Then status 400
    * print response
    And match response == '#object'
    #VALIDAR ESQUEMA
    And string current_schema = response
    And string expected_schema = read('classpath:schema/schema-error-400.json')
    And assert schema.isValid(current_schema, expected_schema)