<script>
    import Sidebar from "../layout/Sidebar.svelte";
    import Header from "../layout/Header.svelte";
    import BroadCast from "../layout/navigation/BroadCast.svelte";

    // Modules Svelte
    import { onMount } from 'svelte'

    // Props
    export let uriForm = ''
    // Data
    let csrfValue = null

    onMount(() => {
        csrfValue = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    })
</script>

<Sidebar/>
<Header/>
<div class="container">
    <BroadCast
            content="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquid aspernatur consequuntur distinctio, dolore ex fugit illum in modi necessitatibus nisi non, odio rerum, soluta unde ut? Cumque rem sequi voluptates."
            title="Create Category"/>
    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Form to Create Category</h5>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Distinctio eos hic illum ipsam molestiae,
                mollitia porro quibusdam reiciendis rem suscipit vel vero? Exercitationem fugit illo iure libero natus
                ratione recusandae.</p>
            <form action={uriForm} method="POST">
                <input type="hidden" name="authenticity_token" value={csrfValue}>
                <div class="form-group">
                    <label for="name">Category Name</label>
                    <input class="form-control" id="name" name="name" placeholder="Enter your name..." type="text">
                </div>
                <div class="form-group">
                    <label for="slug">Category Slug</label>
                    <input class="form-control" id="slug" name="slug" placeholder="Enter your slug..." type="text">
                </div>
                <div class="form-group">
                    <label for="resume">Category Content</label>
                    <textarea class="form-control" cols="30" id="resume" name="resume" placeholder="Your content..."
                              rows="10"></textarea>
                </div>
                <button class="btn btn-primary" type="submit">Send</button>
            </form>
        </div>
    </div>
</div>