[![REUSE status](https://api.reuse.software/badge/github.com/SAP-samples/abap-platform-rap630-ext)](https://api.reuse.software/info/github.com/SAP-samples/abap-platform-rap630-ext)

# RAP630 - Use ABAP Cloud for developer extensibility - Extension project
<!-- Please include descriptive title -->

<!--- Register repository https://api.reuse.software/register, then add REUSE badge:
[![REUSE status](https://api.reuse.software/badge/github.com/SAP-samples/REPO-NAME)](https://api.reuse.software/info/github.com/SAP-samples/REPO-NAME)
-->

## Description
<!-- Please include SEO-friendly description -->

This repository contains additionial material for the RAP hands-on workshop called _RAP630 - Use ABAP Cloud for developer extensibility_. It contains the source code of the solution for the extension of the package **ZRAP630_SOL**.  

The source code is stored in a separate GitHub repository so that it is possible to install **ZRAP630_SOL** and **ZRAP630_SOL_EXT** in two different software components.  

In the script both packages are both stored in **ZLOCAL** so that the exercises can also be performed in shared trial systems.  In addition the components of the base RAP BO would have to be C0- and C1-released.  

## Requirements

The solution package **ZRAP630_SOL** of the GitHub repository `https://github.com/SAP-samples/abap-platform-rap630` has to be installed first, since this package contains the code to extend the same.

## Download and Installation

The package ZRAP630_SOL_EXT that contains the solution of this workshop can be downloaded via abapGIT into an *SAP BTP, ABAP Environment* system or into the *SAP S/4HANA Cloud, ABAP environment* system.

> Please note that this package has already been installed in the SAP BTP, ABAP Environment Trial systems !   
> So there is no need to install it on an ABAP Environment trial system.   

<details>
  <summary>Click to expand download and installation steps.</summary>
   
1. Create a package **'ZRAP630_SOL_EXT'** with **'ZLOCAL'** as the superpackage.  
2. Link this package with the URL of the RAP630 GitHub repository `https://github.com/SAP-samples/abap-platform-rap630-ext`.
3. Use the branch `main`.
4. Pull changes.
5. Use mass activation to activate the objects that have been imported in step 3.
6. Test the service binding `ZRAP630UI_SHOP_O4_SOL` of the base RAP business object that is being extended.  
   
</details>

## Known Issues
<!-- You may simply state "No known issues. -->

## How to obtain support
[Create an issue](https://github.com/SAP-samples/<repository-name>/issues) in this repository if you find a bug or have questions about the content.
 
For additional support, [ask a question in SAP Community](https://answers.sap.com/questions/ask.html).

## Contributing
If you wish to contribute code, offer fixes or improvements, please send a pull request. Due to legal reasons, contributors will be asked to accept a DCO when they create the first pull request to this project. This happens in an automated fashion during the submission process. SAP uses [the standard DCO text of the Linux Foundation](https://developercertificate.org/).

## License
Copyright (c) 2023 SAP SE or an SAP affiliate company. All rights reserved. This project is licensed under the Apache Software License, version 2.0 except as noted otherwise in the [LICENSE](LICENSE) file.
