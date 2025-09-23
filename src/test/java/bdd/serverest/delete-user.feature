Feature: Eliminar usuario por ID
  Como un administrador del sistema,
  Quiero poder gestionar los usuarios a través de la API,
  Para administrar la base de datos de usuarios.

  Background:
    * url urlBase
    #VALIDAR  ESQUEMA JSON
    * def schema = Java.type('util.schemaValidator')

  @tag6 @regresion
  Scenario: Eliminar usuario por ID
    #OBETENER ID DE USUARIO
    * def obtenerId = call read('classpath:bdd/serverest/post-user.feature@creacionUsuario')
    * def id = obtenerId.id
    #ELIMINAR USUARIO POR ID
    Given path '/usuarios/' + id
    * print id
    When method DELETE
    Then status 200
    * print response
    And match response.message == '#regex ^(Registro excluído com sucesso|Nenhum registro excluído)$'
    #VALIDAR ESQUEMA
    And string current_schema = response
    And string expected_schema = read('classpath:schema/schema-delete-user.json')
    And assert schema.isValid(current_schema, expected_schema)