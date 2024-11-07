FROM node:latest

ARG PORT=3030
WORKDIR /app
ENV PATH="${PATH}:/root/.cargo/bin"

COPY . .

RUN apt-get update && apt-get install -y curl
RUN curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- -y
RUN npm install
RUN npm i --prefix rs/0.1.0-alpha.7/
RUN touch server/util/poaps.txt
RUN touch server/util/assignments.json
RUN npm run build

EXPOSE ${PORT}
CMD ["node", "build/server/index.bundle.js"]
