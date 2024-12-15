<template>
    <div class="alert-container">
      <h1>Repartidores por comuna</h1>
      <form @submit.prevent="fetchroundsmanData">
    <div>
      <label for="comuna">Comunas</label>
      <select id="comuna" v-model="selectedComunas" multiple size="5">
        <option v-for="comuna in comunas">
          {{ comuna}}
        </option>
      </select>
    </div>
    <button type="submit">Buscar</button>
  </form>

      <div v-if="loading" class="loading">Buscando repartidores...</div>
      <div v-else-if="error" class="error">{{ error }}</div>
      <div v-else-if="roundsmanData.length === 0" class="no-data">
        No hay datos disponibles.
      </div>
      <div v-else>
        <table class="alert-table">
          <thead>
            <tr>
              <th>Repartidor ID</th>
              <th>Nombre</th>
              <th>Numero</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="roundsman in roundsmanData" :key="roundsman.delivery_person_id">
              <td>{{ roundsman.delivery_person_id }}</td>
              <td>{{ roundsman.name }}</td>
              <td>{{ roundsman.contact_number }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </template>

  <script>
  import axios from "axios";

  export default {
    name: "RoundsmanPoligon",
    data() {
      return {
        loading: true,
        error: null,
        roundsmanData: [],
        comunas: [],
        comuna: null,
      };
    },
    methods: {
      fetchroundsmanData() {
        axios
          .get("http://localhost:8080/delivery/persons-in-comuna",comuna, {
            headers: {
              Authorization: `Bearer ${localStorage.getItem("jwt")}`,
            },
          })
          .then((response) => {
            this.roundsmanData = response.data;
            this.loading = false;
            console.log("Repartidores:", this.roundsmanData);
          })
          .catch((err) => {
            console.error("Error al obtener los repartidores:", err);
            this.error = "Hubo un problema al cargar los repartidores.";
            this.loading = false;
          });
      },
      fetchComunas() {
        axios
          .get("http://localhost:8080/client/comunas", {
            headers: {
              Authorization: `Bearer ${localStorage.getItem("jwt")}`,
            },
          })
          .then((response) => {
            console.log("Comunas:", response.data);
            this.comunas = response.data;
            this.loading = false;
          })
          .catch((err) => {
            console.error("Error al obtener las comunas:", err);
            this.error = "Hubo un problema al cargar las comunas.";
            this.loading = false;
          });
      },
      created() {
        this.fetchComunas();
      },
    },
  };
  </script>

  <style scoped>
  .alert-container {
    padding: 20px;
    max-width: 800px;
    margin: 0 auto;
    background-color: #ffffff;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    color: #000; /* Garantizar que todo el texto dentro sea negro */
  }

  h1 {
    text-align: center;
    margin-bottom: 20px;
    color: #000; /* Asegura que el título sea negro */
  }

  .loading,
  .error,
  .no-data {
    text-align: center;
    font-size: 1.2em;
    margin-top: 20px;
    color: #000; /* Garantiza texto negro para mensajes */
  }

  .error {
    color: red; /* Error debe mantenerse rojo */
  }

  .alert-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
  }

  .alert-table th,
  .alert-table td {
    padding: 10px;
    text-align: left;
    border: 1px solid #ddd;
    color: #000; /* Texto negro para encabezados y celdas */
  }

  .alert-table th {
    background-color: #f4f4f4;
    color: #000; /* Texto negro en encabezados */
  }

  .alert-table tbody tr:hover {
    background: #f9f9f9;
    color: #000; /* Texto negro al pasar el ratón */
  }
  </style>
