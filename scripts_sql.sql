-- Criacao do banco de dados
CREATE DATABASE sgdb_estacio;


-- Criacao da tabela de usuarios (jovens da comunidade)
CREATE TABLE usuarios (
    usuarioid SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    datanascimento DATE NOT NULL,
    escolaridade VARCHAR(50) NOT NULL,
    genero VARCHAR(20) NOT NULL,
    datacadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Criacao da tabela de cursos
CREATE TABLE cursos (
    cursoid SERIAL PRIMARY KEY,
    nomecurso VARCHAR(100) NOT NULL,
    descricao TEXT,
    datainicio DATE NOT NULL,
    datafim DATE NOT NULL,
    cargahoraria INT NOT NULL,
    requisitos VARCHAR(255)
);

-- Criacao da tabela de inscricoes (associacao entre usuarios e cursos)
CREATE TABLE inscricoes (
    inscricaoid SERIAL PRIMARY KEY,
    usuarioid INT NOT NULL,
    cursoid INT NOT NULL,
    datainscricao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'inscrito',
    FOREIGN KEY (usuarioid) REFERENCES usuarios(usuarioid),
    FOREIGN KEY (cursoid) REFERENCES cursos(cursoid)
);

-- Criacao da tabela de recursos (materiais didaticos, equipamentos, etc.)
CREATE TABLE recursos (
    recursoid SERIAL PRIMARY KEY,
    nomerecurso VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    quantidade INT NOT NULL,
    disponibilidade BOOLEAN DEFAULT TRUE
);

-- Criacao da tabela de avaliacoes (feedback dos usuarios)
CREATE TABLE avaliacoes (
    avaliacaoid SERIAL PRIMARY KEY,
    usuarioid INT NOT NULL,
    cursoid INT NOT NULL,
    nota INT CHECK (nota >= 1 AND nota <= 5),
    comentarios TEXT,
    dataavaliacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuarioid) REFERENCES usuarios(usuarioid),
    FOREIGN KEY (cursoid) REFERENCES cursos(cursoid)
);

-- Insercao de dados de exemplo

-- Insercao de usuarios
INSERT INTO usuarios (nome, email, datanascimento, escolaridade, genero)
VALUES
('Ana Silva', 'ana.silva@example.com', '2002-05-20', 'medio completo', 'feminino'),
('Pedro Souza', 'pedro.souza@example.com', '2001-08-15', 'medio incompleto', 'masculino'),
('Mariana Lima', 'mariana.lima@example.com', '2003-12-10', 'fundamental completo', 'feminino');

-- Insercao de cursos
INSERT INTO cursos (nomecurso, descricao, datainicio, datafim, cargahoraria, requisitos)
VALUES
('introducao a programacao', 'Curso basico de programacao em Python.', '2023-01-15', '2023-03-15', 60, 'nenhum'),
('design grafico', 'Curso de design grafico utilizando Adobe Photoshop e Illustrator.', '2023-02-01', '2023-04-01', 80, 'conhecimento basico de informatica'),
('marketing digital', 'Curso sobre estrategias de marketing digital e criacao de conteudo.', '2023-03-01', '2023-05-01', 50, 'nenhum');

-- Insercao de inscricoes
INSERT INTO inscricoes (usuarioid, cursoid)
VALUES
(1, 1),
(2, 1),
(2, 2),
(3, 3);

-- Insercao de recursos
INSERT INTO recursos (nomerecurso, tipo, quantidade)
VALUES
('computador', 'equipamento', 10),
('manual de programacao python', 'material didatico', 20),
('licenca adobe photoshop', 'software', 5);

-- Insercao de avaliacoes
INSERT INTO avaliacoes (usuarioid, cursoid, nota, comentarios)
VALUES
(1, 1, 5, 'Excelente curso, muito didatico!'),
(2, 1, 4, 'Bom curso, mas poderia ter mais exemplos praticos.'),
(3, 3, 5, 'Adorei o curso de marketing digital, muito util!');

-- Consultas de exemplo

-- Visualizar todos os usuarios e suas inscricoes
SELECT u.nome, c.nomecurso, i.status
FROM usuarios u
JOIN inscricoes i ON u.usuarioid = i.usuarioid
JOIN cursos c ON i.cursoid = c.cursoid;

-- Visualizar a disponibilidade dos recursos
SELECT nomerecurso, tipo, quantidade, disponibilidade
FROM recursos;

-- Visualizar avaliacoes dos cursos
SELECT u.nome, c.nomecurso, a.nota, a.comentarios
FROM avaliacoes a
JOIN usuarios u ON a.usuarioid = u.usuarioid
JOIN cursos c ON a.cursoid = c.cursoid;

-- Atualizar o status de uma inscricao
UPDATE inscricoes
SET status = 'concluido'
WHERE inscricaoid = 1;

-- Deletar um recurso
DELETE FROM recursos 
WHERE recursoid = 3;