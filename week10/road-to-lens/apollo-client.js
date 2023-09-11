import { ApolloClient, InMemoryCache } from "@apollo/client";

// initialize a client with the base url pointed at the Lens Matic Mainnet API
const client = new ApolloClient({
  uri: "https://api.lens.dev",
  cache: new InMemoryCache(),
});

export default client;
