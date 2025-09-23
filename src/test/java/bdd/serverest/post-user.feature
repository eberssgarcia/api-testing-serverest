Feature: Crear usuario
  Como un administrador del sistema,
  Quiero poder gestionar los usuarios a través de la API,
  Para administrar la base de datos de usuarios.

  Background:
    * url urlBase
    #GENERAR DE NOMBRE DEUSUARIO
    * def serverest = Java.type('util.dataGenerator')
    #VALIDAR  ESQUEMA JSON
    * def schema = Java.type('util.schemaValidator')

  @tag1 @regresion @creacionUsuario
  Scenario: Crear usuario válido
    #CREAR USUARIO
    Given path '/usuarios'
    * def reqBody = read('classpath:request/post-user/req-registro-usuario.json')
    * def nombreUsuario = serverest.generarNombreUsuario()
    * set reqBody.nome = nombreUsuario
    * set reqBody.email = "user_" + nombreUsuario + "@mail.com"
    * print reqBody
    And request reqBody
    When method POST
    Then status 201
    * print response
    * def id = response._id
    * print id
    And match response.message == "Cadastro realizado com sucesso"
    And match response._id != null
    #VALIDAR ESQUEMA
    And string current_schema = response
    And string expected_schema = read('classpath:schema/schema-post-user.json')
    And assert schema.isValid(current_schema, expected_schema)

  @tag2 @regresion
  Scenario: Crear usuario con email repetido
    #CREAR USUARIO CON EMAIL REPETIDO
    Given path '/usuarios'
    * def reqBody = read('classpath:request/post-user/req-registro-usuario.json')
    And request reqBody
    When method POST
    Then status 400
    And match response.message == "Este email já está sendo usado"
    #VALIDAR ESQUEMA
    And string current_schema = response
    And string expected_schema = read('classpath:schema/schema-error-400.json')
    And assert schema.isValid(current_schema, expected_schema)

