<template>
    <div class="alert-container">
      <h1>Almacen mas cercano</h1>
      <form @submit.prevent="fetchStoreData">
        <div>
          <label for="region">Regiones</label>
            <select id="region" v-model="region">
              <option v-for="region in regions">
                {{ region }}
              </option>
            </select>
        </div>
        <button type="submit">Buscar</button>
      </form>

      <div v-if="loading" class="loading">Buscando regiones...</div>
      <div v-else-if="error" class="error">{{ error }}</div>
      <div v-else-if="almacen.length === 0" class="no-data">
        No hay datos disponibles.
      </div>
      <div v-else>
        <table class="alert-table">
          <thead>
            <tr>
              <th>Almacen ID</th>
              <th>Espacio geometrico</th>
              <th>Latitud</th>
              <th>Longitud</th>
            </tr>
          </thead>
          <tbody>
              <td>{{ this.almacen.warehouse_id }}</td>
              <td>{{ this.almacen.geom }}</td>
              <td>{{ this.almacen.latitude}}</td>
              <td>{{ this.almacen.longitude }}</td>
          </tbody>
        </table>
      </div>
    </div>
  </template>

  <script>
  import axios from "axios";

  export default {
    name: "Asignate",
    data() {
      return {
        loading: true,
        error: null,
        almacen: [],
        order_id: "",
        client_id: "",
      };
    },
    mounted() {
      this.fetchStore();
    },
    methods: {
      fetchStore() {
        this.client_id = JSON.parse(sessionStorage.getItem("client_id"));
        this.order_id = JSON.parse(sessionStorage.getItem("order_id"));
        axios
          .get("http://localhost:8080/warehouse/nearest",{params:{id:this.client_id}}, {
            headers: {
              Authorization: `Bearer ${localStorage.getItem("jwt")}`,
            },
          })
          .then((response) => {
            this.almacen = response.data;
            this.loading = false;
            console.log("Almacenes:", this.almacen);
          })
          .catch((err) => {
            console.error("Error al obtener el almacen:", err);
            this.error = "Hubo un problema al cargar el almacen.";
            this.loading = false;
          });
      },
      created() {
        this.fetchStore();
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