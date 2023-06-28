import * as api from "@opentelemetry/api";
import { AsyncHooksContextManager } from "@opentelemetry/context-async-hooks";
import express, { Express } from "express";
import opentelemetry from "@opentelemetry/api";

const PORT: number = parseInt(process.env.PORT || "8080");
const app: Express = express();

// custom func
const getRandomNumber = (min: number, max: number) => {
  return Math.floor(Math.random() * (max - min) + min);
};

// context
const contextManager = new AsyncHooksContextManager();
contextManager.enable();
api.context.setGlobalContextManager(contextManager);

const key = api.createContextKey("Key to store a value");
const ctx = api.context.active(); // Returns ROOT_CONTEXT when no context is active

// tracer
const tracer = opentelemetry.trace.getTracer("express-app");

// routes
api.context.with(ctx.setValue(key, "hello"), async () => {
  console.log(api.context.active().getValue(key));
});

app.get("/rolldice", (req, res) => {
  tracer.startActiveSpan(
    "app.main",
    { attributes: { context: "some context" } },
    (span) => {
      // span.setAttributes({ msg: "hello" });
      span.addEvent("I am called!", {
        "log.severity": "info",
        "log.message": "Hello from span!",
        "http.request.id": "abc",
      });
      span.setStatus({
        code: 1,
      });
      span.end();
    }
  );
  res.status(200);
  res.json({ status: "ok", data: getRandomNumber(1, 6).toString() });
});

// api server listener
app.listen(PORT, () => {
  console.log(`Listening for requests on http://localhost:${PORT}`);
});
