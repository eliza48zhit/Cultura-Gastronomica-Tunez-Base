// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title CulturaTunez
 * @dev Registro de intensidad de picante y mecanica de masas finas.
 * Serie: Sabores de Africa (14/54)
 */
contract CulturaTunez {

    struct Plato {
        string nombre;
        string ingredientes;
        string preparacion;
        uint256 nivelCapsaicina;   // Escala de Harissa (1-10)
        bool usaMalsouka;          // Masa finisima para el Brik
        bool corazonLiquido;       // Objetivo tecnico del huevo en el Brik
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public registroCulinario;
    uint256 public totalRegistros;
    address public owner;

    constructor() {
        owner = msg.sender;
        // Inauguramos con el Brik a l'Oeuf (Icono tecnico)
        registrarPlato(
            "Brik a l'Oeuf", 
            "Masa Malsouka, huevo, atun, alcaparras, perejil.",
            "Envolver los ingredientes en la masa y freir rapidamente para que el huevo quede crudo por dentro.",
            3, 
            true, 
            true
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _ingredientes,
        string memory _preparacion,
        uint256 _capsaicina, 
        bool _malsouka,
        bool _liquido
    ) public {
        require(bytes(_nombre).length > 0, "Nombre requerido");
        require(_capsaicina <= 10, "Escala picante: 1 a 10");

        totalRegistros++;
        registroCulinario[totalRegistros] = Plato({
            nombre: _nombre,
            ingredientes: _ingredientes,
            preparacion: _preparacion,
            nivelCapsaicina: _capsaicina,
            usaMalsouka: _malsouka,
            corazonLiquido: _liquido,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre,
        uint256 capsaicina,
        bool malsouka,
        bool liquido,
        uint256 likes
    ) {
        require(_id > 0 && _id <= totalRegistros, "ID inexistente");
        Plato storage p = registroCulinario[_id];
        return (p.nombre, p.nivelCapsaicina, p.usaMalsouka, p.corazonLiquido, p.likes);
    }
}
