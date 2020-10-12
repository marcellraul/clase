import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../views/Home.vue";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "inicio",
    component: () => import("../components/inicio.vue"),
  },
  {
    path: "/about",
    name: "About",
    component: () =>
      import(/* webpackChunkName: "about" */ "../views/About.vue"),
  },
  {
    path: "/contact",
    name: "contact",
    component: () =>
      import(/* webpackChunkName: "about" */ "../views/Contact.vue"),
  },
  {
    path: "/crear-articulos",
    name: "crear-articulos",
    component: () => import("../components/CrearArticulo.vue"),
  },
  {
    path: "/articulos",
    name: "listar-articulos",
    component: () =>
      import(
        /* webpackChunkName: "about" */ "../components/ListarArticulos.vue"
      ),
  },
  {
    path: "/editar-articulo/:id",
    name: "editar-articulos",
    component: () =>
      import(
        /* webpackChunkName: "about" */ "../components/EditarArticulos.vue"
      ),
  },

  {
    path: "/estudiantes",
    name: "listar-estudiantes",
    component: () =>
      import(
        /* webpackChunkName: "about" */ "../components/Estudiantes/ListarEstudiantes.vue"
      ),
  },
  {
    path: "/clase",
    name: "listar-estudiantes",
    component: () =>
      import(/* webpackChunkName: "about" */ "../components/Clase/Clase.vue"),
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;
