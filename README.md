# FREE LUNCH

A integração de Smart Contracts em uma plataforma para freelancers e empregadores pode trazer benefícios significativos tanto para os profissionais autônomos quanto para as empresas que buscam seus serviços.

Os Smart Contracts são contratos digitais baseados em blockchain, que podem ser programados para executar automaticamente termos e condições específicas quando certas condições predefinidas são atendidas.

Nesse contexto, eles podem ajudar a garantir segurança, transparência e eficiência nas transações entre freelancers e empregadores.

Para os freelancers, o uso de Smart Contracts pode fornecer garantias adicionais ao estabelecer acordos com clientes.

## Por exemplo

Pagamentos automáticos: Os Smart Contracts podem ser configurados para liberar pagamentos assim que determinadas etapas do trabalho forem concluídas ou conforme cronograma pré-estabelecido.

Isso evita atrasos nos pagamentos ou riscos de não pagamento.

Proteção contra inadimplência: Os fundos necessários para pagar pelo trabalho realizado pelos freelancers podem ser bloqueados em um contrato inteligente antes mesmo do início da colaboração, garantindo que o pagamento seja recebido após a conclusão bem-sucedida do projeto.

Avaliações automatizadas: Após a finalização do trabalho, o sistema pode registrar automaticamente avaliações dos clientes sobre o freelancer por meio de um mecanismo integrado no contrato inteligente. Isso ajuda a construir reputação online confiável.

Já para os empregadores:
Garantia de entrega satisfatória: Com um contrato inteligente adequado, as partes envolvidas podem definir claramente os objetivos e critérios de sucesso do projeto.

Os pagamentos podem ser liberados somente quando o freelancer entregar os resultados conforme acordado.

Transparência na alocação de recursos: O uso de contratos inteligentes permite que as partes tenham visibilidade sobre como e onde seus fundos estão sendo utilizados, garantindo a transparência nas transações financeiras.

Além disso, para facilitar a comunicação entre freelancers e empregadores, um grupo no WhatsApp com bot criado para notificar sobre novas oportunidades disponíveis. Essa abordage ajuda a manter os usuários atualizados e permite uma interação rápida e direta entre as partes interessadas.

A plataforma também pode fornecer recursos adicionais, como um sistema de busca avançada por contratos e perfis, permitindo que freelancers encontrem trabalhos adequados às suas especializações e empregadores encontrem profissionais qualificados para seus projetos.

Além disso, é importante considerar o aspecto de segurança na plataforma. A integração de Smart Contracts garante que as transações sejam protegidas contra fraudes ou atividades maliciosas.

Os contratos inteligentes são imutáveis ​​e registrados em uma blockchain, garantindo a autenticidade dos acordos estabelecidos.

Em resumo, a estratégia do hackathon visa desenvolver um site/app com interface intuitiva para conectar freelancers e empregadores através de smart contracts seguros.

Essa abordagem traz benefícios significativos para ambas as partes envolvidas ao garantir pagamentos automáticos, proteção contra inadimplência, avaliações automatizadas, garantias de entrega satisfatória e transparência nas transações financeiras.

Além disso, a notificação sobre novos trabalhos via grupo no WhatsApp facilita a comunicação entre os usuários da plataforma.

Este projeto é um aplicativo colaborativo por X Y Z W P Q com [Next.js](https://nextjs.org), [Next-Auth](nextauth.org), [ZenStack](https://zenstack.dev), [Supabase](https://supabase.com) e [Vercel](vercel.com).

Neste aplicativo fictício, os usuários podem ser convidados para espaços de trabalho onde podem colaborar em tarefas. Listas públicas de tarefas são visíveis para todos os membros do espaço de trabalho.

Veja uma demonstração em: [https://ftw.vercel.app/](https://ftw.vercel.app/).

## Recursos

- Cadastro/login do usuário
- Criação de espaços de trabalho e convite de membros
- Segregação dos dados e controle das permissões

## Stack

- Nodejs
- React
- NextJS
- PostgreSQL
- heroicons
- next-auth
- @prisma/client
- @vercel/analytics
- Tailwind CSS
- daisyUI — Tailwind CSS Components
- nanoid
- swr
- bcryptjs
- The One API

## Implementação

- O model dos dados está localizado em `/schema.zmodel`.
- Uma API CRUD automática é montada em `/api/model` por meio do arquivo `pages/api/model/[...path].ts`.
- Hooks CRUD da biblioteca [SWR](https://swr.vercel.app/) são gerados na pasta `lib/hooks`.

## Executando o exemplo

1. Configure um novo banco de dados PostgreSQL:

    Foi usado [Supabase](https://supabase.com)

2. Instale as dependências:

    ```bash
    npm install
    ```

3. Gere o código do servidor e cliente a partir do modelo:

    ```bash
    npm run generate
    ```

4. Sincronize o esquema do banco de dados:

     ```bash
     npm run db:push
     ```

5. Inicie o servidor de desenvolvimento:

    ```bash
    npm run dev
    ```

6. Deploy

    ```bash
    git add .
    git commit -am "hello friend"
    git pull
    git push
    ```
