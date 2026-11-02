package com.petconecta.backend.controller;

import com.petconecta.backend.model.Usuario;
import com.petconecta.backend.model.Animal;
import com.petconecta.backend.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import java.util.List;

@Controller
public class UsuarioController {

    @Autowired
    private UsuarioService usuarioService;

    @GetMapping("/login")
    public String exibirPaginaLogin(Model model) {
        model.addAttribute("Logado", false);
        return "telaLogin";
    }

    @GetMapping("/usuarios/filtrar")
    public String exibirPaginaFiltro(Model model, Usuario usuarioLogado) {
        List<Animal> animaisFiltrados = usuarioService.filtrarAnimais(usuarioLogado);

        model.addAttribute("listaAnimais", animaisFiltrados);

        return "tela-filtrada";
    }


}
