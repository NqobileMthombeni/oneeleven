const PORT = process.env.PORT || 3000;
const NODE_ENV = process.env.NODE_ENV || 'development';

export const config = {
  port: typeof PORT === 'string' ? parseInt(PORT, 10) : PORT,
  nodeEnv: NODE_ENV,
  isDevelopment: NODE_ENV === 'development',
  isProduction: NODE_ENV === 'production',
};
