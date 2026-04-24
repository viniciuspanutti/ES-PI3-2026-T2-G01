/**Vinícius
 * Explicação do código ->
 */


import { setGlobalOptions } from "firebase-functions";
export * as exchange from "./exchange";

setGlobalOptions({ maxInstances: 10 });

export * from "./startups";