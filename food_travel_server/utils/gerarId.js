module.exports = function gerarId(prefix = "") {
  const id = Math.random().toString(36).substring(2, 10);
  return prefix ? `${prefix}${id}` : id;
};
