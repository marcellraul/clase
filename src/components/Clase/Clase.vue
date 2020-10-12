<template>
  <v-container>
    <v-row class="text-center">
      <v-col class="mb-2">
        <h2 class="display-2 font-weight-bold mb-3">
          Listado de Clases
        </h2>
      </v-col>
    </v-row>
    <v-row>
      <v-col>
        <template>
          <v-row justify="center">
            <v-dialog v-model="dialog2" persistent max-width="600px">
              <template
                v-slot:activator="{ on, attrs }"
                class="d-flex align-start"
              >
                <v-btn
                  class="mx-2"
                  fab
                  dark
                  color="indigo"
                  v-bind="attrs"
                  v-on="on"
                >
                  <v-icon dark>mdi-plus</v-icon>
                </v-btn>
              </template>
              <v-card>
                <v-card-title class="d-flex justify-center">
                  <span class="align-center">Clase</span>
                </v-card-title>
                <v-card-text>
                  <v-container>
                    <form v-on:submit.prevent="guardarClase()">
                      <v-row>
                        <v-col cols="12">
                          <v-text-field
                            label="Nombre"
                            v-model="clase.clase"
                            hint="Nombre de la clase"
                            persistent-hint
                            required
                          ></v-text-field>
                        </v-col>

                        <v-spacer></v-spacer>
                        <v-col cols="  12" sm="6" md="4"> </v-col>
                      </v-row>
                    </form>
                  </v-container>
                </v-card-text>
                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn color="blue darken-1" text @click="dialog2 = false">
                    Close
                  </v-btn>
                  <v-btn
                    type="submit"
                    color="blue darken-1"
                    outlined
                    text
                    @click="(dialog2 = false), guardarClase()"
                  >
                    Save
                  </v-btn>
                </v-card-actions>
              </v-card>
            </v-dialog>
          </v-row>
        </template>
      </v-col>
    </v-row>

    <v-row class="text-center">
      <v-col cols="12">
        <v-simple-table fixed-header class="elevation-3">
          <template v-slot:default>
            <thead>
              <tr>
                <th class="text-center">ID</th>
                <th class="text-center">Clase</th>
                <th class="text-center">Fecha Creada</th>
                <th class="text-center">Acciones</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="clase in clases" :key="clase.id">
                <td>{{ clase.id }}</td>
                <td>{{ clase.clase }}</td>
                <td>{{ clase.fechacreada }}</td>
                <td>
                  <v-btn
                    @click.stop="dialog3 = true"
                    @click="obtenerClase(clase.id)"
                    fab
                    small
                    color="primary"
                    ><v-icon>mdi-pencil</v-icon>
                  </v-btn>
                  <v-btn
                    @click.stop="dialog = true"
                    @click="id = clase.id"
                    fab
                    small
                    color="error"
                    ><v-icon>mdi-delete</v-icon>
                  </v-btn>
                </td>
              </tr>
            </tbody>
          </template>
        </v-simple-table>
      </v-col>
    </v-row>

    <!---modal editarr-->
    <v-row>
      <v-col>
        <template>
          <v-row justify="center">
            <v-dialog v-model="dialog3" persistent max-width="600px">
              <template class="d-flex align-start"> </template>
              <v-card>
                <v-card-title class="d-flex justify-center">
                  <span class="align-center">Estudiante Update</span>
                </v-card-title>
                <v-card-text>
                  <v-container>
                    <form v-on:submit.prevent="actClase()">
                      <v-row>
                        <v-col cols="12">
                          <v-text-field
                            label="Nombre*"
                            v-model="clase.clase"
                            hint="Nombre de la Clase"
                            persistent-hint
                            required
                          ></v-text-field>
                        </v-col>

                        <v-spacer></v-spacer>
                        <v-col cols="  12" sm="6" md="4"> </v-col>
                      </v-row>
                    </form>
                  </v-container>
                </v-card-text>
                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn
                    color="blue darken-1"
                    text
                    @click="(dialog3 = false), limpiarClase()"
                  >
                    Close
                  </v-btn>
                  <v-btn
                    type="submit"
                    color="blue darken-1"
                    outlined
                    text
                    @click="(dialog3 = false), actClase()"
                  >
                    Save
                  </v-btn>
                </v-card-actions>
              </v-card>
            </v-dialog>
          </v-row>
        </template>
      </v-col>
    </v-row>

    <!-- ventana de diálogo para eliminar registros -->
    <v-dialog v-model="dialog" max-width="350">
      <v-card>
        <v-card-title class="headline"
          >¿Desea eliminar el registro?</v-card-title
        >
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn @click="dialog = false">Cancelar</v-btn>
          <v-btn @click="confirmarBorrado(id)" color="error">Aceptar</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

    <!-- componente snackbar para mostrar mensaje de eliminación -->
    <v-snackbar v-model="snackbar" color="success">
      {{ textsnack }}
      <template v-slot:action="{ attrs }">
        <v-btn text v-bind="attrs" @click="snackbar = false">Cerrar</v-btn>
      </template>
    </v-snackbar>

    <!-- componente snackbar para mostrar mensaje de eliminación -->
    <v-snackbar v-model="snackbarnew" color="success">
      {{ textsnacknew }}
      <template v-slot:action="{ attrs }">
        <v-btn text v-bind="attrs" @click="snackbarnew = false">Cerrar</v-btn>
      </template>
    </v-snackbar>

    <!-- componente snackbar para mostrar mensaje de eliminación -->
    <v-snackbar v-model="snackbaract" color="primary">
      {{ textsnackact }}
      <template v-slot:action="{ attrs }">
        <v-btn text v-bind="attrs" @click="snackbaract = false">Cerrar</v-btn>
      </template>
    </v-snackbar>
  </v-container>
</template>

<script>
import axios from "axios";
export default {
  name: "listar-estudiantes",
  mounted() {
    // this.obtenerEstudiantes();
    this.obtenerClases();
  },
  data() {
    return {
      menu: false,
      modal: false,
      menu2: false,
      dialog: false,
      dialog2: false,
      dialog3: false,
      clases: null,
      clase: {
        id: "",
        clase: "",
      },
      id: null,
      snackbar: false,
      textsnack: "¡Registro Eliminado!",
      snackbarnew: false,
      textsnacknew: "¡Registro Creado!",
      snackbaract: false,
      textsnackact: "¡Registro Actualizado!",
    };
  },
  methods: {
    limpiarClase() {
      this.clase = {};
    },
    guardarClase() {
      var router = this.$router;
      const formData = new FormData();
      formData.append("clase", this.clase.clase);
      //console.log("estudiante");
      axios
        .post("http://localhost/apirest/clase.php", formData)
        .then(() => {
          this.obtenerClases();
          this.dialog = false;
          this.snackbarnew = true;
          this.clase = {};
        })
        .catch(function(error) {
          console.log(error);
        });
    },
    obtenerClases() {
      axios
        .get("http://localhost/apirest/clase.php")
        .then((r) => {
          this.clases = r.data;
          console.log(this.clases);
        })
        .catch(function(error) {
          console.log(error);
        });
    },

    obtenerClase(id) {
      this.id = id;
      axios
        .get("http://localhost/apirest/clase.php?id=" + this.id)
        .then((r) => {
          this.clase = r.data;
        })
        .catch(function(error) {
          console.log(error);
        });
    },
    actClase() {
      axios
        .put(
          "http://localhost/apirest/clase.php?id=" +
            this.id +
            "&clase=" +
            this.clase.clase
        )
        .then(() => {
          this.obtenerClases();
          this.dialog = false;
          this.snackbaract = true;
          this.clase = {};
        })
        .catch(function(error) {
          console.log(error);
        });
    },
    confirmarBorrado(id) {
      axios
        .delete("http://localhost/apirest/clase.php?id=" + id)
        .then(() => {
          this.obtenerClases();
          this.dialog = false;
          this.snackbar = true;
        })
        .catch(function(error) {
          console.log(error);
        });
    },
  },
};
</script>
