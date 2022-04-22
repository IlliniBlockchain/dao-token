import axios from 'axios';

const instance = axios.create();

// Setup axios interceptors
instance.interceptors.request.use(
  config => {
    // Do something before request is sent

    // Set base url
    config.baseURL = process.env.REACT_APP_API_URL;
    config.headers.common['Content-Type'] = 'application/json';
    config.headers.common['Accept'] = 'application/json';

    return config;
  },
  error => {
    // Do something with request error
    return Promise.reject(error);
  }
);

// Get events from etherscan
export const getEvents = address => {
  return instance
    .get(
      `https://api.etherscan.io/api?module=logs&action=getLogs&fromBlock=0&toBlock=latest&address=${address}&apikey=${process.env.REACT_APP_ETHERSCAN_API_KEY}`
    )
    .then(response => {
      return response.data.result;
    })
    .catch(error => {
      console.log(error);
    });
};
