exports.handler = async (event) => {
  const response = {
    statusCode: 200,
    body: JSON.stringify('Hello from Lambda from existing S3 (managed file, managed compressio)!'),
  };
  return response;
};
