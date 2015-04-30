export default {
  Code: {
    CANCELED: "CANCELED",

    SERVER_BUSY: "SERVER_BUSY",

    UNAUTHORIZED: "UNAUTHORIZED",
    OPERATION_NOT_ALLOWD: "OPERATION_NOT_ALLOWD",

    NOT_FOUND: "NOT_FOUND",
    INVALID_VALUE: "INVALID_VALUE"
  },

  create(params={}) {
    const error = new Error();
    for (let i in params) {
      error[i] = params[i];
    }
    return error;
  },

  rise(params={}) {
    throw self.create(params);
  }
}