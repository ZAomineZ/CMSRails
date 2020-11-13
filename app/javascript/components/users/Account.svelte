<script>
    // MODULES HTML
    import Sidebar from "../layout/Sidebar.svelte";
    import Header from "../layout/Header.svelte";
    import BroadCast from "../layout/navigation/BroadCast.svelte";
    import Alert from "../concern/Alert.svelte";
    import FormAccount from "./FormAccount.svelte";

    // PROPS
    export let user = null
    export let flashSuccess = null
    export let flashDanger = null
</script>

<Sidebar/>
<Header/>
<div class="container">
    <BroadCast
            content="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquid aspernatur consequuntur distinctio, dolore ex fugit illum in modi necessitatibus nisi non, odio rerum, soluta unde ut? Cumque rem sequi voluptates."
            title="Account to '{user.username}' "/>
    {#if flashDanger !== null || flashSuccess !== null}
        <Alert type={flashSuccess ? 'success' : 'danger'} message={flashSuccess ? flashSuccess : flashDanger}/>
    {/if}
    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Form to Create Post</h5>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Distinctio eos hic illum ipsam molestiae,
                mollitia porro quibusdam reiciendis rem suscipit vel vero? Exercitationem fugit illo iure libero natus
                ratione recusandae.</p>
            <FormAccount uriForm="/account/{user.id}" user={user}/>
        </div>
    </div>
</div>