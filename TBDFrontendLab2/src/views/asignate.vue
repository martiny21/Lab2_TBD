<template>
    <div class="report-container">
      <h1>Ordenes pagadas</h1>
      <div v-if="loading" class="loading">Cargando ordenes...</div>
      <div v-else-if="error" class="error">{{ error }}</div>
      <div v-else-if="orderData.length === 0" class="no-data">
        No hay datos disponibles.
      </div>
      <div v-else>
        <table class="report-table">
          <thead>
            <tr>
              <th>Orden ID</th>
              <th>Fecha</th>
              <th>Estado</th>
              <th>Total</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="order in orderData" :key="order.order_id">
              <td v-if="order.order_id!=null">{{ order.order_id }}</td>
              <td v-else>{{ "Sistema" }}</td>
              <td>{{ order.order_date }}</td>
              <td>{{ order.state }}</td>
              <td>{{ order.total }}</td>
              <td><button @click="asign(order.client_id,order.order_id)">Asignar envio</button></td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </template>

  <script>
  import axios from "axios";

  export default {
    name: "OrderAsignate",
    data() {
      return {
        loading: true,
        error: null,
        orderData: [],
      };
    },
    methods: {
      fetchClientQueryReport() {
        axios
          .get("http://localhost:8080/order/getorderpay", {
            headers: {
              Authorization: `Bearer ${localStorage.getItem("jwt")}`,
            },
          })
          .then((response) => {
            this.orderData = response.data;
            this.loading = false;
            console.log("Reporte de consultas de clientes:", this.orderData);
          })
          .catch((err) => {
            console.error("Error al obtener el reporte:", err);
            this.error = "Hubo un problema al cargar el reporte.";
            this.loading = false;
          });
      },
      asign(client_id,order_id){
        sessionStorage.setItem("client_id", client_id);
        sessionStorage.setItem("order_id", order_id);
        this.$router.push("/payinfo");
      }
    },
    created() {
      this.fetchClientQueryReport();
    },
  };
  </script>

  <style scoped>
  .report-container {
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

  .report-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
  }

  .report-table th,
  .report-table td {
    padding: 10px;
    text-align: left;
    border: 1px solid #ddd;
    color: #000; /* Texto negro para encabezados y celdas */
  }

  .report-table th {
    background-color: #f4f4f4;
    color: #000; /* Texto negro en encabezados */
  }

  .report-table tbody tr:hover {
    background: #f9f9f9;
    color: #000; /* Texto negro al pasar el ratón */
  }
  </style>