# Proyecto de automatización de pruebas con Karate DSL - ServeRest API

Automatización de pruebas para microservicios/APIs usando **[Karate DSL](https://github.com/karatelabs/karate)** y **Java 17** bajo Maven.  
Este proyecto implementa pruebas **E2E (CRUD completo de usuarios)** contra la API pública [ServeRest](https://serverest.dev/) usando patron de diseño POM (Page Object Model).


<table>
  <tr> 
    <th>
      <h3>
          <a href="[https://github.com/eberssgarcia/api-continuous-testing](https://github.com/eberssgarcia/api-testing-serverest.git)"> ⏩ <br/> Karate DSL</a>
      </h3>
   </th>
    <td>Desarrollado en IntelliJ IDEA</td>
  </tr>
</table>

## 📌 Objetivos

- Validar endpoints de la API de **Usuarios** (`/usuarios`) en **ServeRest**.
- Implementar casos **positivos y negativos** para operaciones CRUD.
- Utilizar **esquemas JSON** para validar respuestas.
- Generar **datos dinámicos** (usuarios únicos).
- Ejecutar pruebas de forma flexible (por tags, suites o ambientes).
- Documentar de forma clara la configuración y ejecución.

## 🛠️ Herramientas y/o tecnologías a usar

- **IntelliJ IDEA** – IDE para desarrollo.
- **Java 17** – Lenguaje base.
- **Apache Maven 3.9.9** – Gestión de dependencias y ejecución.
- **Karate DSL 1.2.0** – Framework de pruebas E2E para APIs.
- **JUnit 5** – Integración de ejecución (runner).
- **Cucumber Reporting** – Reportes en HTML (opcional).
- **JSON Schema Validator** – Validación de esquemas.

## 📁 Estructura de carpetas

    src/test/java/bdd/serverest/
    ├── features/              # Features CRUD de usuarios
    │   ├── get-users.feature
    │   ├── post-user.feature
    │   ├── get-user-by-id.feature
    │   ├── put-user.feature
    │   └── delete-user.feature
    ├── request/               # Cuerpos de request JSON
    ├── schema/                # Validaciones JSON Schema
    └── utils/                 # Helpers (generador de datos, schemaValidator)

## ⚙️ Configurar proyecto

1. Crear proyecto de tipo MAVEN
2. Ingresar las dependencias de Karate DSL en el archivo POM.xml
3. Ejecutar comando `mvn install` a través de la terminal
4. Ejecutar comando `mvn test` para ejecutar el RunnerTest. Este ejeecuta todos los test de prueba
   <br>**Execution by CMD**
5. Ejecutar comando `mvn clean test "-Dkarate.options=--tags @tag1"` para ejecutar un test de prueba en específico
   <br>**Execution by Git Bash Terminal**
6. Ejecutar comando `mvn clean test -Dkarate.options="--tags @tag1"` para ejecutar un test de prueba en específico
7. Ejecutar comando `mvn clean test -Dkarate.options="--tags @tag1" -Dkarate.env=dev` para ejecutar un test con
   ambiente específico.
8. Ejecutar comando `mvn clean test -Dkarate.options="--tags @regresion" -Dkarate.env=dev` para ejecutar varios test con etiqueta @regresion en ambiente específico.
9. Archivo de configuración `karate-config.js` para definir variables globales y/o por ambiente.
10. Crear estructura de carpetas para features, request, response y schema.

**Nota**: Si ya tienes definido test de prueba, puedes ejecutar el comando `mvn install -DskipTests` para omitir dichos
tests.

## Dependencias

1. **Dependencia de Karate DSL**

**`Repositorio`**: https://mvnrepository.com

        <dependency>
            <groupId>com.intuit.karate</groupId>
            <artifactId>karate-core</artifactId>
            <version>1.2.0</version> <!-- Asegúrate de utilizar la versión más reciente de Karate DSL -->
            <scope>test</scope>
        </dependency>

2. **Dependencia para integración con JUnit 5 (opcional, si prefieres utilizar JUnit)**

**`Repositorio`**: https://mvnrepository.com

        <dependency>
            <groupId>com.intuit.karate</groupId>
            <artifactId>karate-junit5</artifactId>
            <version>1.2.0</version> <!-- Asegúrate de utilizar la versión más reciente de Karate DSL -->
            <scope>test</scope>
        </dependency>

3. **Dependencia para generar informes de Cucumber (opcional, si deseas generar informes)**

**`Repositorio`**: https://mvnrepository.com

       <dependency>
            <groupId>net.masterthought</groupId>
            <artifactId>cucumber-reporting</artifactId>
            <version>5.3.1</version>
            <scope>test</scope>
        </dependency>
4. **Dependencia para validación de schemas**

**`Repositorio`**: https://mvnrepository.com

        <dependency>
            <groupId>com.github.java-json-tools</groupId>
            <artifactId>json-schema-validator</artifactId>
            <version>2.2.14</version>
        </dependency>

##### Ejecución de los features de manera independiente o grupo, utilizar lo siguiente:

| bdd/serverest/features                   | TAG              |
|------------------------------------------|------------------|
| Ejecución de todos los casos de pruebas. | @regresion       |
| Ejecutar casos de pruenas independientes | @tag*            | 
 | Ejecutar escenario que genera data      | @creacionUsuario |

#### Ejemplo

```cucumber
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
```

## 📊 Reportes
- Reportes en HTML generados automáticamente en la ruta `target/surefire-reports/karate-summary.html` después de la ejecución de las pruebas.

## 🚀 Buenas prácticas

- Separar features por endpoint.
- Usar Background para configuración común.
- Generar datos dinámicos con helpers (dataGenerator).
- Validar con JSON Schema en schema.
- Nombrar escenarios con etiquetas (@regresion, @tag*).

<div>
  <a href="https://www.linkedin.com/in/eberssgarcia/">
    <img src="https://img.shields.io/badge/@eberssgarcia--lightgrey?logo=linkedin&amp;style=social">
  </a>
</div>
