const swaggerJSDoc = require('swagger-jsdoc');

const options = {
  definition: {
    openapi: '3.0.0', // Versão do OpenAPI
    info: {
      title: 'Minha API', // Título da API
      version: '1.0.0', // Versão da API
      description: 'Documentação da API usando Swagger',
    },
    servers: [
      { url: 'http://localhost:3000' }, // URL base da API
    ],
    components: {
      securitySchemes: {
        BearerAuth: { // Exemplo de autenticação
          type: 'http',
          scheme: 'bearer',
          bearerFormat: 'JWT',
        },
      },
    },
  },
  apis: ['./routes/*.js'], // Caminho para os arquivos de rotas
};

const swaggerSpec = swaggerJSDoc(options);
module.exports = swaggerSpec;
