package util;

import com.fasterxml.jackson.databind.JsonNode;
import com.github.fge.jackson.JsonLoader;
import com.github.fge.jsonschema.core.report.ProcessingReport;
import com.github.fge.jsonschema.main.JsonSchema;
import com.github.fge.jsonschema.main.JsonSchemaFactory;

import java.util.logging.Logger;

public class schemaValidator {

    private static final Logger LOGGER = Logger.getLogger(schemaValidator.class.getName());

    public static boolean isValid(String expectedSchema, String jsonResponse) throws Exception {
        if (expectedSchema.isEmpty() && jsonResponse.isEmpty()) {
            LOGGER.info("Both expected schema and json response are empty");
            return true;
        }

        JsonNode schemaNode = JsonLoader.fromString(expectedSchema);
        JsonSchemaFactory factory = JsonSchemaFactory.byDefault();
        JsonSchema jsonSchema = factory.getJsonSchema(schemaNode);
        JsonNode jsonNode = JsonLoader.fromString(jsonResponse);
        ProcessingReport report = jsonSchema.validate(jsonNode);

        if (!report.isSuccess()) {

            throw new Exception("JSON Schema validation failed with errors: " + report);
        }

        return true;
    }

}