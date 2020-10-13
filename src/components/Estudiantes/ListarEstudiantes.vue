<template>
  <v-container>
    <v-row class="text-center">
      <v-col class="">
        <h2 class="display-2 font-weight-bold ">
          Listado de Estudiantes
        </h2>
      </v-col>
    </v-row>
    <v-form v-model="valid">
      <v-row>
        <v-col>
          <template>
            <v-row justify="center">
              <v-dialog v-model="dialog2" persistent max-width="600px">
                <template v-slot:activator="{ on, attrs }" class="">
                  <v-btn
                    class=""
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
                    <span class="align-center">Estudiante Profile</span>
                  </v-card-title>
                  <v-card-text>
                    <v-container>
                      <form v-on:submit.prevent="guardarEstudiante()">
                        <v-row>
                          <v-col cols="12">
                            <v-text-field
                              label="Nombre*"
                              v-model="estudiante.nombre"
                              :rules="nameRules"
                              :counter="20"
                              hint="Nombre del Estudiante"
                              persistent-hint
                              required
                            ></v-text-field>
                          </v-col>

                          <v-col cols="12">
                            <v-select
                              v-model="estudiante.clases"
                              :items="clase"
                              :rules="[(v) => !!v || 'Item is required']"
                              item-text="clase"
                              item-value="clase"
                              label="Clase"
                              required
                            ></v-select>
                          </v-col>

                          <v-col cols="12">
                            <v-menu
                              ref="menu"
                              v-model="menu"
                              :close-on-content-click="false"
                              :return-value.sync="date"
                              transition="scale-transition"
                              offset-y
                              min-width="290px"
                            >
                              <template v-slot:activator="{ on, attrs }">
                                <v-text-field
                                  v-model="date"
                                  label="Fecha de Nacimiento"
                                  prepend-icon="mdi-calendar"
                                  readonly
                                  v-bind="attrs"
                                  v-on="on"
                                ></v-text-field>
                              </template>
                              <v-date-picker
                                v-model="estudiante.fechanac"
                                no-title
                                scrollable
                                color="primary"
                              >
                                <v-spacer></v-spacer>
                                <v-btn
                                  text
                                  color="primary"
                                  @click="menu = false"
                                >
                                  Cancel
                                </v-btn>
                                <v-btn
                                  text
                                  color="primary"
                                  @click="$refs.menu.save(date)"
                                >
                                  OK
                                </v-btn>
                              </v-date-picker>
                            </v-menu>
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
                      @click="(dialog2 = false), limpiarEstudiante()"
                    >
                      Close
                    </v-btn>
                    <v-btn
                      :disabled="!valid"
                      type="submit"
                      color="blue darken-1"
                      outlined
                      text
                      @click="(dialog2 = false), validate, guardarEstudiante()"
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
    </v-form>
    <v-row class="text-center">
      <v-col cols="12">
        <v-simple-table fixed-header class="elevation-6">
          <template v-slot:default>
            <thead>
              <tr>
                <th class="text-center">ID</th>
                <th class="text-center">Nombre</th>
                <th class="text-center">Clase</th>
                <th class="text-center">Fecha Nac.</th>
                <th class="text-center">Acciones</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="estudiante in estudiantes" :key="estudiante.id">
                <td>{{ estudiante.id }}</td>
                <td>{{ estudiante.nombre }}</td>
                <td>{{ estudiante.clases }}</td>
                <td>{{ estudiante.fechanac }}</td>
                <td>
                  <v-btn
                    @click.stop="dialog3 = true"
                    @click="obtenerEstudiante(estudiante.id)"
                    fab
                    small
                    color="primary"
                    ><v-icon>mdi-pencil</v-icon>
                  </v-btn>
                  <v-btn
                    @click.stop="dialog = true"
                    @click="id = estudiante.id"
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
                    <form v-on:submit.prevent="actEstudiante()">
                      <v-row>
                        <v-col cols="12">
                          <v-text-field
                            label="Nombre*"
                            v-model="estudiante.nombre"
                            hint="Nombre del Estudiante"
                            persistent-hint
                            required
                          ></v-text-field>
                        </v-col>

                        <v-col cols="12">
                          <v-select
                            v-model="estudiante.clases"
                            :items="clase"
                            item-text="clase"
                            item-value="clase"
                            label="Clase"
                            required
                          ></v-select>
                        </v-col>

                        <v-col cols="12">
                          <v-menu
                            ref="menu2"
                            v-model="menu2"
                            :close-on-content-click="false"
                            :return-value.sync="date"
                            transition="scale-transition"
                            offset-y
                            min-width="290px"
                          >
                            <template v-slot:activator="{ on, attrs }">
                              <v-text-field
                                v-model="estudiante.fechanac"
                                label="Fecha de Nacimiento"
                                prepend-icon="mdi-calendar"
                                readonly
                                v-bind="attrs"
                                v-on="on"
                              ></v-text-field>
                            </template>
                            <v-date-picker
                              v-model="estudiante.fechanac"
                              no-title
                              scrollable
                              color="primary"
                            >
                              <v-spacer></v-spacer>
                              <v-btn
                                text
                                color="primary"
                                @click="menu2 = false"
                              >
                                Cancel
                              </v-btn>
                              <v-btn
                                text
                                color="primary"
                                @click="$refs.menu2.save(date)"
                              >
                                OK
                              </v-btn>
                            </v-date-picker>
                          </v-menu>
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
                    @click="(dialog3 = false), limpiarEstudiante()"
                  >
                    Close
                  </v-btn>
                  <v-btn
                    type="submit"
                    color="blue darken-1"
                    outlined
                    text
                    @click="(dialog3 = false), actEstudiante()"
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

  data() {
    return {
      valid: false,
      firstname: "",
      lastname: "",
      nameRules: [
        (v) => !!v || "Name is required",
        (v) => v.length <= 10 || "Name must be less than 10 characters",
      ],
      date: new Date().toISOString().substr(0, 10),
      menu: false,
      menu2: false,
      modal: false,
      menu2: false,
      dialog: false,
      dialog2: false,
      dialog3: false,
      estudiantes: null,
      clases: [],
      clas: {
        id: "",
        clase: null,
      },
      estudiante: {
        id: "",
        nombre: "",
        clases: "",
        fechanac: new Date().toISOString().substr(0, 10),
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
  computed: {
    clase() {
      return Object.values(this.clases);
    },
  },
  mounted() {
    this.obtenerEstudiantes();
    this.obtenerClase();
  },
  methods: {
    validate() {
      this.$refs.form.validate();
    },
    limpiarEstudiante() {
      this.estudiante = {};
    },
    guardarEstudiante() {
      var router = this.$router;
      const formData = new FormData();
      formData.append("nombre", this.estudiante.nombre);
      formData.append("clases", this.estudiante.clases);
      formData.append("fechanac", this.estudiante.fechanac);
      //console.log("estudiante");
      axios
        .post("http://localhost/apirest/estudiantes.php", formData)
        .then(() => {
          this.obtenerEstudiantes();
          this.dialog = false;
          this.snackbarnew = true;
          this.estudiante = {};
        })
        .catch(function(error) {
          console.log(error);
        });
    },
    obtenerClase() {
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
    obtenerEstudiantes() {
      axios
        .get("http://localhost/apirest/estudiantes.php")
        .then((r) => {
          this.estudiantes = r.data;
          console.log(this.estudiantes);
        })
        .catch(function(error) {
          console.log(error);
        });
    },

    obtenerEstudiante(id) {
      this.id = id;
      axios
        .get("http://localhost/apirest/estudiantes.php?id=" + this.id)
        .then((r) => {
          this.estudiante = r.data;
        })
        .catch(function(error) {
          console.log(error);
        });
    },
    actEstudiante() {
      axios
        .put(
          "http://localhost/apirest/estudiantes.php?id=" +
            this.id +
            "&nombre=" +
            this.estudiante.nombre +
            "&clases=" +
            this.estudiante.clases +
            "&fechanac=" +
            this.estudiante.fechanac
        )
        .then(() => {
          this.obtenerEstudiantes();
          this.dialog = false;
          this.snackbaract = true;
          this.estudiante = {};
        })
        .catch(function(error) {
          console.log(error);
        });
    },
    confirmarBorrado(id) {
      axios
        .delete("http://localhost/apirest/estudiantes.php?id=" + id)
        .then(() => {
          this.obtenerEstudiantes();
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
