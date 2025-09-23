Feature: Actualizar usuario
  Como un administrador del sistema,
  Quiero poder gestionar los usuarios a través de la API,
  Para administrar la base de datos de usuarios.

  Background:
    * url urlBase
    #GENERAR DE NOMBRE DEUSUARIO
    * def serverest = Java.type('util.dataGenerator')
    #VALIDAR  ESQUEMA JSON
    * def schema = Java.type('util.schemaValidator')

  @tag5 @regresion
  Scenario: Actualizar usuario por ID
    #OBETENER ID DE USUARIO
    * def obtenerId = call read('classpath:bdd/serverest/post-user.feature@creacionUsuario')
    * def id = obtenerId.id
    #ACTUALIZAR USUARIO POR ID (USUARIO CREADO)
    Given path '/usuarios/' + id
    * def reqBody = read('classpath:request/put-user/req-actualizar-usuario.json')
    * def nombreUsuario = serverest.generarNombreUsuario()
    * set reqBody.nome = nombreUsuario
    * set reqBody.email = "user_" + nombreUsuario + "@mail.com"
    And request reqBody
    When method PUT
    Then status 200
    * print response
    And match response.message == 'Registro alterado com sucesso'
    #VALIDAR ESQUEMA
    And string current_schema = response
    And string expected_schema = read('classpath:schema/schema-post-user.json')
    And assert schema.isValid(current_schema, expected_schema)


  @tag8 @regresion
  Scenario: Actualizar usuario con email repetido
    #CREAR USUARIO CON EMAIL REPETIDO
    Given path '/usuarios'
    * def reqBody = read('classpath:request/put-user/req-actualizar-usuario.json')
    And request reqBody
    When method POST
    Then status 400
    And match response.message == "Este email já está sendo usado"
    #VALIDAR ESQUEMA
    And string current_schema = response
    And string expected_schema = read('classpath:schema/schema-error-400.json')
    And assert schema.isValid(current_schema, expected_schema)
