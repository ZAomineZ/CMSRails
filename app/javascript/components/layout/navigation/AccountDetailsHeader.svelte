<script>
    // LIB
    import {User} from "../../../packs/request/User";

    // PROPS
    export let csrfValue = ''

    // Data
    let dropdown = false

    // METHODS

    /**
     * @param {Event} event
     */
    function handleToggle(event) {
        dropdown = !dropdown
    }

    /**
     * Send action logout to user entity
     *
     * @param {Event} event
     */
    async function logout(event)
    {
        const response = await (new User()).resLogout(event, csrfValue)
        if (response.success) {
            window.location = '/'
        }
    }
</script>

<ul class="navbar-nav ml-auto">
    <li class="nav-item dropdown {dropdown ? 'show' : ''}">
        <a class="nav-link" href="#" on:click|preventDefault={handleToggle} role="button">
            <i class="fa fa-ellipsis-v"></i>
        </a>
        <ul class="dropdown-menu dropdown-menu-right">
            <li>
                <a class="dropdown-item" href="/admin/account">Account</a>
            </li>
            <li class="divider"></li>
            <li>
                <a class="dropdown-item" href="/logout" on:click|preventDefault={logout}>Log Out</a>
            </li>
        </ul>
    </li>
</ul>