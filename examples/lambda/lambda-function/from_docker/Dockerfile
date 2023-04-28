FROM public.ecr.aws/lambda/nodejs:18

# add app
COPY handler.js ${LAMBDA_TASK_ROOT}

ENV NODE_ENV=production

# start app
CMD [ "handler.handler" ]
