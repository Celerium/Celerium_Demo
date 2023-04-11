<h1 align="center">
  <br>
  <a href="http://Celerium.org"><img src="https://raw.githubusercontent.com/Celerium/Celerium/master/.github/workflows/Celerium-Logo-Square-Master.png" alt="_CeleriumDemo" width="200"></a>
  <br>
  _CeleriumDemo
  <br>
</h1>

[![Azure Pipelines](https://dev.azure.com/AzCelerium/CeleriumDemo/_apis/build/status%2FCelerium._CeleriumDemo?branchName=main)](https://dev.azure.com/AzCelerium/CeleriumDemo/_build/latest?definitionId=3&branchName=main)
[![GitHub Pages](https://github.com/Celerium/_CeleriumDemo/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/Celerium/_CeleriumDemo/actions/workflows/pages/pages-build-deployment)
![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/RocketCyberAPI?style=for-the-badge&logo=powershell)
![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/RocketCyberAPI?style=for-the-badge)
![PowerShell Gallery](https://img.shields.io/powershellgallery/p/RocketCyberAPI?style=for-the-badge)
![GitHub](https://img.shields.io/github/license/Celerium/_CeleriumDemo?style=for-the-badge)
![Website](https://img.shields.io/website?label=Celerium.org&style=for-the-badge&url=https%3A%2F%2Fcelerium.org)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/Celerium/_CeleriumDemo?style=for-the-badge)

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]

<p align="center">
  <a href="https://celerium.org"><img alt="Blog" src="https://img.shields.io/website?down_color=red&down_message=Celerium.org&label=Blog&style=for-the-badge&up_color=blue&up_message=Celerium.org&url=https%3A%2F%2Fcelerium.org"></a>
</p>



---
## Buy me a coffee

Whether you use this project, have learned something from it, or just like it, please consider supporting it by buying me a coffee, so I can dedicate more time on open-source projects like this :)

<a href="https://www.buymeacoffee.com/Celerium" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/guidelines/download-assets-sm-2.svg" alt="Buy Me A Coffee" style="width:150px;height:50px;"></a>

---

<a name="readme-top"></a>




<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/othneildrew/Best-README-Template">
    <img src="https://reconshell.com/wp-content/uploads/2021/12/powershell-arrays.png" alt="Logo">
  </a>

  <h3 align="center">Best-README-Template</h3>

  <p align="center">
    An awesome README template to jumpstart your projects!
    <br />
    <a href="https://github.com/othneildrew/Best-README-Template"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/othneildrew/Best-README-Template">View Demo</a>
    ·
    <a href="https://github.com/othneildrew/Best-README-Template/issues">Report Bug</a>
    ·
    <a href="https://github.com/othneildrew/Best-README-Template/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

[![Product Name Screen Shot][product-screenshot]](https://reconshell.com/wp-content/uploads/2021/12/powershell-arrays.png)

There are many great README templates available on GitHub; however, I didn't find one that really suited my needs so I created this enhanced one. I want to create a README template so amazing that it'll be the last one you ever need -- I think this is it.

Here's why:
* Your time should be focused on creating something amazing. A project that solves a problem and helps others
* You shouldn't be doing the same tasks over and over like creating a README from scratch
* You should implement DRY principles to the rest of your life :smile:

Of course, no one template will serve all projects since your needs may be different. So I'll be adding more in the near future. You may also suggest changes by forking this repo and creating a pull request or opening an issue. Thanks to all the people have contributed to expanding this template!

Use the `BLANK_README.md` to get started.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- GETTING STARTED -->
## Getting Started

After importing this module, you will need to configure both the *base URI* & *API access token* that are used to talk with the RocketCyber API.

1. Run `Add-RocketCyberBaseURI`
   * By default, RocketCyber's `https://api-us.rocketcyber.com/v3/account` uri is used.
   * If you have your own API gateway or proxy, you may put in your own custom uri by specifying the `-base_uri` parameter:
     * `Add-RocketCyberBaseURI -base_uri http://myapi.gateway.example.com`

2. Run `Add-RocketCyberAPIKey`
   * It will prompt you to enter in your API access token
   * RocketCyber API access tokens are generated by going to *RocketCyber > Provider Settings > RocketCyber API*

[optional]

1. Run `Export-RocketCyberModuleSettings`

   * This will create a config file at `%UserProfile%\RocketCyberAPI` that securely holds the *base uri* & *API access token* information.
   * Next time you run `Import-Module -Name RocketCyberAPI`, this configuration file will automatically be loaded.
      * :warning: Exporting module settings encrypts your API access token in a format that can **only be unencrypted with your Windows account**. It makes use of PowerShell's `Windows Data Protection API (DPAPI)` type, which uses reversible encrypted tied to your user principal. This means that you cannot copy your configuration file to another computer or user account and expect it to work.
      * :warning: Exporting and importing module settings requires use of the `ConvertTo-SecureString` cmdlet, which I have not tested in PowerShell core.

### Installation

This module can be installed directly from the [PowerShell Gallery](https://www.powershellgallery.com/packages/RocketCyberAPI) with the following command:

* :information_source: This module supports PowerShell 5.0+ and should work in PowerShell Core.

```posh
Install-Module -Name RocketCyberAPI
```

If you are running an older version of PowerShell, or if PowerShellGet is unavailable, you can manually download the *Master* branch and place the *RocketCyberAPI* folder into the (default) `C:\Program Files\WindowsPowerShell\Modules` folder.

After installation (by either methods), load the module into your workspace:

```posh
Import-Module RocketCyberAPI
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [x] Add Changelog
- [x] Add back to top links
- [ ] Add Additional Templates w/ Examples
- [ ] Add "components" document to easily copy & paste sections of the readme
- [ ] Multi-language Support
    - [ ] Chinese
    - [ ] Spanish

See the [open issues](https://github.com/othneildrew/Best-README-Template/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Your Name - [@your_twitter](https://twitter.com/your_username) - email@example.com

Project Link: [https://github.com/your_username/repo_name](https://github.com/your_username/repo_name)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

Use this space to list resources you find helpful and would like to give credit to. I've included a few of my favorites to kick things off!

* [Choose an Open Source License](https://choosealicense.com)
* [GitHub Emoji Cheat Sheet](https://www.webpagefx.com/tools/emoji-cheat-sheet)
* [Malven's Flexbox Cheatsheet](https://flexbox.malven.co/)
* [Malven's Grid Cheatsheet](https://grid.malven.co/)
* [Img Shields](https://shields.io)
* [GitHub Pages](https://pages.github.com)
* [Font Awesome](https://fontawesome.com)
* [React Icons](https://react-icons.github.io/react-icons/search)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/othneildrew/Best-README-Template.svg?style=for-the-badge
[contributors-url]: https://github.com/othneildrew/Best-README-Template/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/othneildrew/Best-README-Template.svg?style=for-the-badge
[forks-url]: https://github.com/othneildrew/Best-README-Template/network/members
[stars-shield]: https://img.shields.io/github/stars/othneildrew/Best-README-Template.svg?style=for-the-badge
[stars-url]: https://github.com/othneildrew/Best-README-Template/stargazers
[issues-shield]: https://img.shields.io/github/issues/othneildrew/Best-README-Template.svg?style=for-the-badge
[issues-url]: https://github.com/othneildrew/Best-README-Template/issues
[product-screenshot]: images/screenshot.png
