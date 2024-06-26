module.exports = {
  testEnvironment: "node",
  transform: {
    "^.+\\.ts$": [
      "ts-jest",
      {
        tsconfig: "tsconfig.json",
      },
    ],
  },
  moduleDirectories: ["node_modules", "src"],
  verbose: true,
};
