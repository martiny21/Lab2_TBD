<template>
    <div class="card">
      <title>
        Página principal
      </title>
      <h1>
        Administración de la tienda
      </h1>
      <p>
        Gestion de personal, clientes y productos
      </p>
    </div>
    <div>
      <button>
        <router-link class="button-link" to="/almacenado">
          Operaciones por cliente
        </router-link>
      </button>
      <button>
        <router-link class="button-link" to="/alerts">
          Alertas de compras
        </router-link>
      </button>
      <button>
        <router-link class="button-link" to="/problem">
          Problemas de stock
        </router-link>
      </button>
      <button>
        <router-link class="button-link" to="/roundsman">
          Repartidores por poligono
        </router-link>
      </button>
      <button>
        <router-link class="button-link" to="/store">
          Almacenes por region
        </router-link>
      </button>
      <button>
        <router-link class="button-link" to="/asignate">
          Asignar envio
        </router-link>
      </button>
    </div>
  </template>

  <style scoped>
  .card {
    margin: 20px;
    padding: 20px;
    border: 5px solid #3a777b;
    background-color: #ffffff;
    color: #3a777b;
    border-radius: 5px;
    flex: auto;
  }

  h1 {
    text-align: center;
  }

  button {
    margin: 10px;
    padding: 10px 20px;
    font-size: 1.2em;
    background-color: #3a777b;
    color: rgb(255, 255, 255);
    border: none;
    border-radius: 5px;
    cursor: pointer;
    text-align: center;
  }

  button:hover {
    background-color: #2a5a5c;
  }

  .button-link {
    text-decoration: none;
    color: white;
  }
  </style>
