<template>
    <div class="alert-container">
      <h1>Almacenes por region</h1>
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
      <div v-else-if="almacenesData.length === 0" class="no-data">
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
            <tr v-for="almacenes in almacenesData" :key="almacenes.warehouse_id">
              <td>{{ almacenes.warehouse_id }}</td>
              <td>{{ almacenes.geom }}</td>
              <td>{{ almacenes.latitude}}</td>
              <td>{{ almacenes.longitude }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </template>

  <script>
  import axios from "axios";

  export default {
    name: "RegionPoligon",
    data() {
      return {
        loading: true,
        error: null,
        almacenesData: [],
        regions: [],
        region: "",
      };
    },
    mounted() {
      this.fetchRegions();
    },
    methods: {
      fetchStoreData() {
        console.log("Region:", this.region);
        axios
          .get("http://localhost:8080/warehouse/region",{params:{regionName:this.region}}, {
            headers: {
              Authorization: `Bearer ${localStorage.getItem("jwt")}`,
            },
          })
          .then((response) => {
            this.almacenesData = response.data;
            this.loading = false;
            console.log("Almacenes:", this.almacenesData);
          })
          .catch((err) => {
            console.error("Error al obtener los almacenes:", err);
            this.error = "Hubo un problema al cargar los almacenes.";
            this.loading = false;
          });
      },
      fetchRegions() {
        axios
          .get("http://localhost:8080/client/regiones", {
            headers: {
              Authorization: `Bearer ${localStorage.getItem("jwt")}`,
            },
          })
          .then((response) => {
            console.log("regions:", response.data);
            this.regions = response.data;
            this.loading = false;
          })
          .catch((err) => {
            console.error("Error al obtener las regions:", err);
            this.error = "Hubo un problema al cargar las regions.";
            this.loading = false;
          });
      },
      created() {
        this.fetchRegions();
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