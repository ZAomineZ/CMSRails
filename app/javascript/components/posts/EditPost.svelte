<script>
    import Sidebar from "../layout/Sidebar.svelte";
    import Header from "../layout/Header.svelte";
    import BroadCast from "../layout/navigation/BroadCast.svelte";

    // Component HTML
    import Form from "./Form.svelte";

    // Props
    export let uriForm = ''
    export let post = {}

    // Data
    let successResponse = null
    let messageResponse  = ''
</script>

<Sidebar/>
<Header/>
<div class="container">
    <BroadCast
            content="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquid aspernatur consequuntur distinctio, dolore ex fugit illum in modi necessitatibus nisi non, odio rerum, soluta unde ut? Cumque rem sequi voluptates."
            title="Edit Post '{post.name}' "/>
    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Form to Edit Post "{post.name}"</h5>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Distinctio eos hic illum ipsam molestiae,
                mollitia porro quibusdam reiciendis rem suscipit vel vero? Exercitationem fugit illo iure libero natus
                ratione recusandae.</p>
            <Form uriForm={uriForm} post={post} successResponse={successResponse} messageResponse={messageResponse} />
        </div>
    </div>
</div>